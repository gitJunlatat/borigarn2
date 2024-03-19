class VerifyOTPModel {
  String? requestId;
  String? refCode;
  String? phonNumber;

  VerifyOTPModel({
    this.requestId,
    this.refCode,
  });

  VerifyOTPModel.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    refCode = json['refCode'];
  }
}
