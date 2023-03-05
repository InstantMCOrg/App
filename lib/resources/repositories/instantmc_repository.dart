import 'dart:convert';
import 'dart:io';

import 'package:InstantMC/constants/config.dart';
import 'package:InstantMC/constants/enums/instantmc_connection_error_type.dart';
import 'package:InstantMC/models/http/LoginResponseModel.dart';
import 'package:InstantMC/models/server_model.dart';
import 'package:InstantMC/resources/apis/instantmc_api.dart';
import 'package:InstantMC/resources/exceptions/instantmc_connection_error_exception.dart';

import '../../models/server_resource_stats_model.dart';

class InstantMCRepository {
  InstantMCApi _api = InstantMCApi();

  String get targetMachineUrl => _api.targetMachineUrl;

  static bool isUrlValid(String url) {
    Uri? uri = Uri.tryParse(url);
    if(uri == null) return false;

    return uri.host != "" && uri.scheme != "" && uri.origin != "";
  }

  void setTargetMachineUrl(String url) {
    _api = InstantMCApi.url(url);
  }

  void setToken(String token) {
    _api.setToken(token);
  }

  Future<bool> isInstantMCAtUrlEndpoint() async {
    final response = await _api.rootRoute();

    final data = jsonDecode(response.data);
    return data.containsKey("server") && data["server"] == kServerName;
  }

  Future<LoginResponseModel> login(String username, String password) async {
    final response = await _api.login(username, password);

    final data = jsonDecode(response.data);

    return LoginResponseModel(data["token"], data["password_change_required"]);
  }

  /// Returns token after successful password change
  Future<String> changePassword(String newPassword) async {
    final response = await _api.changePassword(newPassword);

    final data = jsonDecode(response.data);

    return data["token"];
  }

  Future<List<ServerModel>> getServer() async {
    final response = await _api.getRunningServer();

    final data = jsonDecode(response.data);
    final List<ServerModel> result = List.empty(growable: true);

    for(int i = 0; i < data["server"].length; i++) {
      result.add(ServerModel.fromJSON(data["server"][i]));
    }

    return result;
  }

  Stream<List<ServerResourceStatsModel>> subscribeServerStats(ServerModel server) async* {
    try {
      final ws = await _api.subscribeServerStats(server.id);

      messageCallbackFunction(data) {
        if(data is! String) {
          return null;
        }
        final jsonData = jsonDecode(data);
        final statsList = List<ServerResourceStatsModel>.empty(growable: true);
        for(int i = 0; i < jsonData.length; i++) {
          final cpuUsagePercent = jsonData[i]["cpu_usage_percent"];
          final memoryUsageMb = jsonData[i]["memory_usage_mb"];
          final stats = ServerResourceStatsModel(cpuUsagePercent, server.ramSize, memoryUsageMb);
          statsList.add(stats);
        }
        return statsList;
      }

      onCancel(data) {
        // Disconnected
        //throw InstantMCConnectionErrorException.fromType(InstantMCConnectionErrorType.disconnected);
      }

      // I don't know why we need to pass messageCallbackFunction in onListen in the first place
      await for (final data in ws.timeout(_api.timeout, onTimeout: (_) {print("timeout");}).asBroadcastStream(onListen: messageCallbackFunction, onCancel: onCancel)) {
        // here we got the raw json data. Now we need to parse the list of ServerResourceStatsModel
        final resourceStatsList = messageCallbackFunction(data);
        yield resourceStatsList!;
      }
    } catch(e) {
      // we can leave this empty because the corresponding cubit handles the error
    }
  }
}