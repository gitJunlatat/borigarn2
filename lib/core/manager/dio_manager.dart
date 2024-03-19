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
    String token = 'U2FsdGVkX1/UtFP1DwPxjjmludOU38Gxftqfvo6chIdQqawjSC86Zxk34RmEFSgwD5P2uNXhkxxYX3qlgBZDrR0JnxzSn9iVysW2NyEJMiAmVS6DOZr3YR2mBYS/KM2OsDCM5ETfcy5W4uo5RcJ3+GtN1ASi2mVybC2ZTeol9/GYV+zndAMDM/xDs+53zYEPu5YHA2s7ROMhtUAZNBs4szbl3a6E3lBNOHIlHZbxhVp0clfEhlSvJGMVTCPIp/VzVjpAV/IL0aBn1LMlvrUyqoosLN6sQ8izR8PLwyF9O6TrfPRrX8XFTK1tzv2IKHNVyJVrWke2cTaIW+OEcjGAyhkazhIfi1ppOszswVfktO83uWvJMKNhIRmltPK0fJDYa7a8CvOakEJIPzZctDEt6xsza1HxrkI9YiemtCXqSYfYixeW/dER5uy9ldSNhgJB';
    dio.options.headers['Authorization'] = 'Bearer $token';
  }else {
    String token = 'U2FsdGVkX1/UtFP1DwPxjjmludOU38Gxftqfvo6chIdQqawjSC86Zxk34RmEFSgwD5P2uNXhkxxYX3qlgBZDrR0JnxzSn9iVysW2NyEJMiAmVS6DOZr3YR2mBYS/KM2OsDCM5ETfcy5W4uo5RcJ3+GtN1ASi2mVybC2ZTeol9/GYV+zndAMDM/xDs+53zYEPu5YHA2s7ROMhtUAZNBs4szbl3a6E3lBNOHIlHZbxhVp0clfEhlSvJGMVTCPIp/VzVjpAV/IL0aBn1LMlvrUyqoosLN6sQ8izR8PLwyF9O6TrfPRrX8XFTK1tzv2IKHNVyJVrWke2cTaIW+OEcjGAyhkazhIfi1ppOszswVfktO83uWvJMKNhIRmltPK0fJDYa7a8CvOakEJIPzZctDEt6xsza1HxrkI9YiemtCXqSYfYixeW/dER5uy9ldSNhgJB';
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
  return dio;
}

