import 'package:borigarn/feature/authen/type/authen_flow_type.dart';

class RequestOTPPayload {
  String phone;
  AuthenticationOTPType action;
  String deviceId;
  String uniqueId;

  RequestOTPPayload({
    required this.phone,
    required this.action,
    required this.deviceId,
    required this.uniqueId,

  });




}
