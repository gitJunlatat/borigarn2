class AuthUserInfo {
  String? username;
  String? phone;


  AuthUserInfo({
    this.username,
    this.phone,
  });

  AuthUserInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    phone = json['phone'];
  }
}
