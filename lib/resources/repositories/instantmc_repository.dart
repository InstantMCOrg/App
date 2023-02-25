import 'dart:convert';

import 'package:InstantMC/constants/config.dart';
import 'package:InstantMC/models/http/LoginResponseModel.dart';
import 'package:InstantMC/resources/apis/instantmc_api.dart';

class InstantMCRepository {
  InstantMCApi _api = InstantMCApi();

  static bool isUrlValid(String url) {
    Uri? uri = Uri.tryParse(url);
    if(uri == null) return false;

    return uri.host != "" && uri.scheme != "" && uri.origin != "";
  }

  void setTargetMachineUrl(String url) {
    _api = InstantMCApi.url(url);
  }

  // Throws
  Future<bool> isInstantMCAtUrlEndpoint() async {
    final response = await _api.rootRoute();

    final data = jsonDecode(response.data);
    return data.containsKey("server") && data["server"] == kServerName;
  }

  // Throws
  Future<LoginResponseModel> login(String username, String password) async {
    final response = await _api.login(username, password);

    final data = jsonDecode(response.data);

    return LoginResponseModel(data["token"], data["password_change_required"]);
  }
}