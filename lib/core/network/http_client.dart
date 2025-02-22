import 'package:dio/dio.dart';
import 'package:magic_calendar/core/network/interface/http_client_interface.dart';


class HttpClient implements HttpClientInterface {
  final Dio _dio;

  HttpClient({required String baseUrl})
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 20),
          receiveTimeout: const Duration(seconds: 10),
        )) {
    _dio.interceptors.add(LogInterceptor(
      request: false,
      requestHeader: false,
      responseHeader: false,
      error: false,
    ));
  }

  @override
  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(url, queryParameters: queryParameters);
  }

  @override
  Future<Response> post(String url,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.post(url, data: data, queryParameters: queryParameters);
  }

  @override
  Future<Response> delete(String url,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.delete(url, data: data, queryParameters: queryParameters);
  }
}