import 'package:borigarn/feature/authen/models/request_otp_model.dart';
import 'package:borigarn/feature/authen/type/authen_flow_type.dart';

class VerifyOTPPayload {
  RequestOTPModel requestModel;
  String otpCode;
  AuthenticationOTPType action;

  VerifyOTPPayload({
    required this.requestModel,
    required this.otpCode,
    required this.action,
  });


}
