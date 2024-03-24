import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart';

import 'dio_manager.dart';
import 'dart:developer';
import 'dart:convert';

part 'network.g.dart';

@Riverpod(keepAlive: true)
NetworkManager networkManager(NetworkManagerRef ref) {
  return NetworkManager(ref.watch(dioClientProvider));
}

class NetworkManager {
  final Dio _dio;

  NetworkManager(this._dio);


  Future<T> get<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Function? fromJson,
        required String appBaseUrl,
        Object? data,
        bool onlyData = false,
        bool rawResponse = false,
      }) async {
    try {
      final response = await _dio.get(
        '$appBaseUrl$path',
        queryParameters: queryParameters,
        data: data,
      );

      final responseData = onlyData ? response.data["data"] : response.data;
      // print('\n\n\nPATHsdsd: $path \n ------ \n');
      // printWrapped('$response');
      return rawResponse
          ? response
          : fromJson != null
          ? fromJson(responseData)
          : responseData;
    } catch (e) {
      throw _handleError(e, appBaseUrl, path);
    }
  }

  Future<T> post<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Function? fromJson,
        required String appBaseUrl,
        Object? data,
        bool onlyData = false,
        bool rawResponse = false,
      }) async {
    try {
      log.e("ONSTART");
      final response = await _dio.post(
        '$appBaseUrl$path',
        queryParameters: queryParameters,
        data: data,
      );

      log.e("ONEMD");


      print('\n\n\nPATH: $path \n ------ \n');
      printWrapped('$response');

      final responseData = onlyData ? response.data["data"] : response.data;
      return rawResponse
          ? response
          : fromJson != null
          ? fromJson(responseData)
          : responseData;

    } catch (e) {
      throw _handleError(e, appBaseUrl, path);
    }
  }

  Future<T> patch<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Function? fromJson,
        required String appBaseUrl,
        Object? data,
        bool onlyData = false,
        bool rawResponse = false,
      }) async {
    try {
      final response = await _dio.patch(
        '$appBaseUrl$path',
        queryParameters: queryParameters,
        data: data,
      );
      final responseData = onlyData ? response.data["data"] : response.data;
      return rawResponse
          ? response
          : fromJson != null
          ? fromJson(responseData)
          : responseData;

    } catch (e) {
      throw _handleError(e, appBaseUrl, path);
    }
  }

  Future<T> put<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        Function? fromJson,
        required String appBaseUrl,
        Object? data,
        bool onlyData = false,
        bool rawResponse = false,

      }) async {
    try {
      final response = await _dio.put(
        '$appBaseUrl$path',
        queryParameters: queryParameters,
        data: data,
      );
      final responseData = onlyData ? response.data["data"] : response.data;
      return rawResponse
          ? response
          : fromJson != null
          ? fromJson(responseData)
          : responseData;
    } catch (e) {
      throw _handleError(e, appBaseUrl, path);
    }
  }

  Future<T> delete<T>(
      String path, {
        Map<String, dynamic>? queryParameters,
        required Function fromJson,
        required String appBaseUrl,
        Object? data,
        bool onlyData = false,
      }) async {
    try {
      final response = await _dio.delete(
        '$appBaseUrl$path',
        queryParameters: queryParameters,
        data: data,
      );

      final responseData = onlyData ? response.data["data"] : response.data;
      return fromJson(responseData);
    } catch (e) {
      throw _handleError(e, appBaseUrl, path);
    }
  }

  NetworkException _handleError(dynamic error, String appBaseUrl, String path) {
    if (error is DioException) {
      log.e(' Error Service:: ${appBaseUrl.toUpperCase()}  \n Path:: $path  \n Status code:: ${error.response?.statusCode} \n Response:: ${error.response} ');
      if (error.response != null) {
        final statusCode = error.response?.statusCode;
        final responseData = error.response?.data;
        return NetworkException(
          statusCode: statusCode,
          data: responseData,
        );
      } else {
        return NetworkException(
          data: "No response from server.",
        );
      }
    }
    log.e('Error Cast ${error}');

    return NetworkException(data: 'Unhandle Response');
  }
}

class NetworkException implements Exception {
  final dynamic data;
  final int? statusCode;

  NetworkException({
    this.data,
    this.statusCode,
  });

  @override
  String toString() {
    return 'NetworkException: $data';
  }

  bool isFailure() {
    return statusCode == null;
  }
}



var logs = Logger(
  printer: PrettyPrinter(),
);

var log = Logger(
  printer: PrettyPrinter(methodCount: 0),
);


void printWrapped(String text) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}