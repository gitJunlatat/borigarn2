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
    String accessToken = SharedPrefs().getToken;
    String token = 'U2FsdGVkX183qzZeSsYk2j8J70xDKIe2Bx4p5S8+VenEtfkff0MVv7YeT/P7EoXeM53HUdRaUUHDlEEFPpAfh6eiGZsJNV9OLPRRMgkbDY9sLBhP3486RauQeK3tlz2pwb6QFnr6FFE5l1dLeVdcqLM+nS6Q0ncpM3ahz3xQ42r4gPx9en6giKtLTRn1J+ES6BYg/Je/jDhfStwguyCD/0gtyxHIg38CW1ln8nEUVEsz2rTZbLyxJfYhNrf1szpUNYAbdWyxkrsLgb91k8tk+PAHux7RW4Q+Uemh2YAlhSTD59D+ttjPFNQX7VUVWsOiv93GnDwnvWnkPWlWATwKCqQjucjZ/Q29NV6ekQMK+9QzBXAzdQKptvuT+oa3t12ckl4+gV/7nxIi0GTnEEc8LqTUCfHA54hak9OzAHaiIsSHl/NCrwHEEnl10KxeVjNy';
    dio.options.headers['Authorization'] = 'Bearer $token';
  }else {
    String token = 'U2FsdGVkX183qzZeSsYk2j8J70xDKIe2Bx4p5S8+VenEtfkff0MVv7YeT/P7EoXeM53HUdRaUUHDlEEFPpAfh6eiGZsJNV9OLPRRMgkbDY9sLBhP3486RauQeK3tlz2pwb6QFnr6FFE5l1dLeVdcqLM+nS6Q0ncpM3ahz3xQ42r4gPx9en6giKtLTRn1J+ES6BYg/Je/jDhfStwguyCD/0gtyxHIg38CW1ln8nEUVEsz2rTZbLyxJfYhNrf1szpUNYAbdWyxkrsLgb91k8tk+PAHux7RW4Q+Uemh2YAlhSTD59D+ttjPFNQX7VUVWsOiv93GnDwnvWnkPWlWATwKCqQjucjZ/Q29NV6ekQMK+9QzBXAzdQKptvuT+oa3t12ckl4+gV/7nxIi0GTnEEc8LqTUCfHA54hak9OzAHaiIsSHl/NCrwHEEnl10KxeVjNy';
    dio.options.headers['Authorization'] = 'Bearer $token';
  }
  return dio;
}
