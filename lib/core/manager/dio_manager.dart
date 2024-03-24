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
    String token = 'U2FsdGVkX1/DY8ZFoG1rsNdnuvOToLdjKx8dUU+rGmaaG129xhoQoFDRvT/bRa4t6Qnl47jbqzBGKHscKi3sRnZf+jdjJHxPMeo9c09AkYSkl0ThdzOHtDBSDJ0WhWokHf9G6MtJFh38NDIeu632KL7J80CgjIP/NAlSepTx2TLagYstMxDFz9pTLdwAQ4tf211cWH4ll1rkAe564w5vwa+v1wbPfGvFGdKFrDbDdjpYEcTPqJ0MLMaZ1GBYV0dBghitZlolcGXKy4WpHYapLnhSfsmL+Y+drzABP/m8eVCY9bwQYSTXZeTUG2Cgb6xPxW7BV1OReR8DG2DDnP8AIDbKn3R2YeUSBY5dfjwUicWsgONVYxG7zyaAzh0rUD4OfGzoYFw7fyAiKQz8Q+l9BBq9NsgxpxG47hO8blNDh0YJzx8pqIQdTrgkeFsD4V1x';
    dio.options.headers['Authorization'] = 'Bearer $token';
  }else {
    String token = 'U2FsdGVkX1/DY8ZFoG1rsNdnuvOToLdjKx8dUU+rGmaaG129xhoQoFDRvT/bRa4t6Qnl47jbqzBGKHscKi3sRnZf+jdjJHxPMeo9c09AkYSkl0ThdzOHtDBSDJ0WhWokHf9G6MtJFh38NDIeu632KL7J80CgjIP/NAlSepTx2TLagYstMxDFz9pTLdwAQ4tf211cWH4ll1rkAe564w5vwa+v1wbPfGvFGdKFrDbDdjpYEcTPqJ0MLMaZ1GBYV0dBghitZlolcGXKy4WpHYapLnhSfsmL+Y+drzABP/m8eVCY9bwQYSTXZeTUG2Cgb6xPxW7BV1OReR8DG2DDnP8AIDbKn3R2YeUSBY5dfjwUicWsgONVYxG7zyaAzh0rUD4OfGzoYFw7fyAiKQz8Q+l9BBq9NsgxpxG47hO8blNDh0YJzx8pqIQdTrgkeFsD4V1x';
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
  return dio;
}

