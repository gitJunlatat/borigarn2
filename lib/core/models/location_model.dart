// class LocationModel {
//   List<LocationDetail>? items;
//   int? totalItems;
//
//   Data({this.items, this.totalItems});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['items'] != null) {
//       items = <Items>[];
//       json['items'].forEach((v) {
//         items!.add(new Items.fromJson(v));
//       });
//     }
//     totalItems = json['totalItems'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.items != null) {
//       data['items'] = this.items!.map((v) => v.toJson()).toList();
//     }
//     data['totalItems'] = this.totalItems;
//     return data;
//   }
// }

class LocationModel {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? deletedAt;
  String? deletedBy;
  int? userId;
  String? latitude;
  String? longitude;
  String? name;
  String? address;
  String? customerData;
  bool? isDefault;

  LocationModel(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedAt,
        this.deletedBy,
        this.userId,
        this.latitude,
        this.longitude,
        this.name,
        this.address,
        this.customerData,
        this.isDefault});

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedAt = json['deletedAt'];
    deletedBy = json['deletedBy'];
    userId = json['userId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    address = json['address'];
    customerData = json['customerData'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['deletedAt'] = this.deletedAt;
    data['deletedBy'] = this.deletedBy;
    data['userId'] = this.userId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['address'] = this.address;
    data['customerData'] = this.customerData;
    data['isDefault'] = this.isDefault;
    return data;
  }
}