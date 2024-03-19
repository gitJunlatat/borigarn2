import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'otp_verify_failed.g.dart';

@riverpod
class IsOtpVerifyFailed extends _$IsOtpVerifyFailed {
  @override
  bool build() {
    return false;
  }

  void setFailed() {
    state = true;
  }

  void setDefault() {
    state = false;
  }
}