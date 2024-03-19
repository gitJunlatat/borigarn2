import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'otp_error_count.g.dart';

@riverpod
class OtpErrorCount extends _$OtpErrorCount {
  @override
  int build() {
    return 0;
  }

  void increaseErrorCount() {
    state = state + 1;
  }
}