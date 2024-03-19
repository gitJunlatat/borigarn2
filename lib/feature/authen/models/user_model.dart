class UserModel {
  String? name;
  String? email;
  String? phone;
  String? pictureUrl;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.pictureUrl,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    pictureUrl = json['pictureUrl'];
  }
}