class TokenModel {
  int? userId;
  String? accessToken;
  String? refreshToken;


  TokenModel({
    this.userId,
    this.accessToken,
    this.refreshToken,

  });

  TokenModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }
}
