class RequestOTPModel {
  String? requestId;
  String? refCode;
  String? phoneNumber;


  RequestOTPModel({
    this.requestId,
    this.refCode,
  });

  RequestOTPModel.fromJson(Map<String, dynamic> json) {
    requestId = json['requestId'];
    refCode = json['refCode'];
  }
}
