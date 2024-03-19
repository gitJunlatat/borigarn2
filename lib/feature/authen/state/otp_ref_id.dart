import 'package:borigarn/feature/authen/models/otp_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'otp_ref_id.g.dart';

@riverpod
class OtpRefId extends _$OtpRefId {
  @override
  OTPModel build() {
    return OTPModel('','');
  }

  void setRefId(OTPModel model) {
    state = model;
  }
}