import 'package:dio/dio.dart';

class InstantMCApi {
  final _defaultPort = 25000;
  //final _apiRoutePrefix = "/api";
  final _apiRoutePrefix = "";
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
  }
  
  Future<Response> rootRoute() async {
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
}