import 'package:borigarn/core/prefs/prefs.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_manager.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient(DioClientRef ref) {
  Dio dio = Dio();
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);

  if (SharedPrefs().isAuthentication()) {
    String token = SharedPrefs().getToken;
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  return dio;
}

