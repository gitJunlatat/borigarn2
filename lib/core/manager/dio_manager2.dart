import 'package:borigarn/core/prefs/prefs.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_manager2.g.dart';

@Riverpod(keepAlive: true)
Dio dioClient2(DioClient2Ref ref) {
  Dio dio = Dio();
  dio.options.connectTimeout = const Duration(seconds: 30);
  dio.options.receiveTimeout = const Duration(seconds: 30);
  dio.options.headers['Authorization'] = 'Bearer yothin';
  return dio;
}

