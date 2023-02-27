import 'dart:convert';

import 'package:InstantMC/constants/config.dart';
import 'package:InstantMC/models/http/LoginResponseModel.dart';
import 'package:InstantMC/resources/apis/instantmc_api.dart';

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


}