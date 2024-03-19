class ResetPasswordPayload {
  final String pass;
  final String requestId;
  final String phoneNumber;
  ResetPasswordPayload ({required this.pass, required this.requestId, required this.phoneNumber});
}