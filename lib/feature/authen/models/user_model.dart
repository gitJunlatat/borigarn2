class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? pictureUrl;

  UserModel({
this.id,
    this.name,
    this.email,
    this.phone,
    this.pictureUrl,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    pictureUrl = json['pictureUrl'];
  }
}