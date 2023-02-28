import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

class InstantMCApi {
  final _defaultPort = 25000;
  final _apiRoutePrefix = "/api";
  final _defaultBaseOptions = BaseOptions(
    contentType: Headers.jsonContentType,
    connectTimeout: const Duration(seconds: 5),
    responseType: ResponseType.json,
  );

  late final Dio _dio;
  InstantMCApi({Dio? dio}) : _dio = dio ?? Dio();

  InstantMCApi.url(String baseUrl) {
    final uri = Uri.parse(baseUrl);

    if(!uri.hasPort) {
      // we should add the port
      baseUrl = "$baseUrl:$_defaultPort";
    }
    _dio = Dio(_defaultBaseOptions.copyWith(baseUrl: baseUrl));

    if(!kIsWeb) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true; // temporary solution, lets encrypt certificates otherwise won't work
        return client;
      };
    }
  }

  String get targetMachineUrl => _dio.options.baseUrl;

  void setToken(String token) {
    _dio.options = _dio.options.copyWith(headers: {"auth":token});
  }
  
  Future<Response> rootRoute() async {
    if(kDebugMode) {
      print("Checking if ${_dio.options.baseUrl} is a valid InstantMC server...");
    }
    return _dio.get("$_apiRoutePrefix/");
  }

  Future<Response> login(String username, String password) async {
    return _dio.post("$_apiRoutePrefix/login",
      data: FormData.fromMap({
        "username": username,
        "password": password
      })
    );
  }

  Future<Response> changePassword(String newPassword) async {
    return _dio.post("$_apiRoutePrefix/user/password/change",
      data: FormData.fromMap({
        "password": newPassword
      })
    );
  }

  Future<Response> getRunningServer() async {
    return _dio.get("$_apiRoutePrefix/server");
  }
}