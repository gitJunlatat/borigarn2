
import 'package:borigarn/feature/home/models/service_model.dart';

class BookingModel {
  String? createdAt;
  String? createdBy;
  String? date;
  String? deletedAt;
  String? deletedBy;
  int? id;
  List<String>? images;
  bool? isEstimate;
  String? note;
  String? number;
  String? price;
  String? remark;
  // String? staffId;
  String? status;
  String? time;
  String? updatedAt;
  String? updatedBy;
  int? userId;
  Service? service;
  UserLocationId? userLocationId;

  BookingModel(
      {this.createdAt,
        this.createdBy,
        this.date,
        this.deletedAt,
        this.deletedBy,
        this.id,
        this.images,
        this.isEstimate,
        this.note,
        this.number,
        this.price,
        this.remark,
        // this.staffId,
        this.status,
        this.time,
        this.updatedAt,
        this.updatedBy,
        this.userId,
        this.service,
        this.userLocationId});

  BookingModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    date = json['date'];
    deletedAt = json['deletedAt'];
    deletedBy = json['deletedBy'];
    id = json['id'];
    images = json['images'];
    isEstimate = json['isEstimate'];
    note = json['note'];
    number = json['number'];
    price = json['price'];
    remark = json['remark'];
    // staffId = json['staffId'];
    status = json['status'];
    time = json['time'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    userId = json['userId'];
    service =
    json['service'] != null ? Service.fromJson(json['service']) : null;
    userLocationId = json['userLocationId'] != null
        ? UserLocationId.fromJson(json['userLocationId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['date'] = date;
    data['deletedAt'] = deletedAt;
    data['deletedBy'] = deletedBy;
    data['id'] = id;
    data['images'] = images;
    data['isEstimate'] = isEstimate;
    data['note'] = note;
    data['number'] = number;
    data['price'] = price;
    data['remark'] = remark;
    // data['staffId'] = staffId;
    data['status'] = status;
    data['time'] = time;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['userId'] = userId;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    if (userLocationId != null) {
      data['userLocationId'] = userLocationId!.toJson();
    }
    return data;
  }
}

// class Service {
//   String? createdAt;
//   String? createdBy;
//   String? customData;
//   String? deletedAt;
//   String? deletedBy;
//   int? id;
//   bool? isActive;
//   bool? isPopular;
//   String? nameEn;
//   String? nameTh;
//   String? updatedAt;
//   String? updatedBy;
//
//   Service(
//       {this.createdAt,
//         this.createdBy,
//         this.customData,
//         this.deletedAt,
//         this.deletedBy,
//         this.id,
//         this.isActive,
//         this.isPopular,
//         this.nameEn,
//         this.nameTh,
//         this.updatedAt,
//         this.updatedBy});
//
//   Service.fromJson(Map<String, dynamic> json) {
//     createdAt = json['createdAt'];
//     createdBy = json['createdBy'];
//     customData = json['customData'];
//     deletedAt = json['deletedAt'];
//     deletedBy = json['deletedBy'];
//     id = json['id'];
//     isActive = json['isActive'];
//     isPopular = json['isPopular'];
//     nameEn = json['nameEn'];
//     nameTh = json['nameTh'];
//     updatedAt = json['updatedAt'];
//     updatedBy = json['updatedBy'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['createdAt'] = this.createdAt;
//     data['createdBy'] = this.createdBy;
//     data['customData'] = this.customData;
//     data['deletedAt'] = this.deletedAt;
//     data['deletedBy'] = this.deletedBy;
//     data['id'] = this.id;
//     data['isActive'] = this.isActive;
//     data['isPopular'] = this.isPopular;
//     data['nameEn'] = this.nameEn;
//     data['nameTh'] = this.nameTh;
//     data['updatedAt'] = this.updatedAt;
//     data['updatedBy'] = this.updatedBy;
//     return data;
//   }
// }

class UserLocationId {
  String? address;
  String? createdAt;
  String? createdBy;
  String? customerData;
  String? deletedAt;
  String? deletedBy;
  int? id;
  bool? isDefault;
  String? latitude;
  String? longitude;
  String? name;
  String? updatedAt;
  String? updatedBy;
  int? userId;

  UserLocationId(
      {this.address,
        this.createdAt,
        this.createdBy,
        this.customerData,
        this.deletedAt,
        this.deletedBy,
        this.id,
        this.isDefault,
        this.latitude,
        this.longitude,
        this.name,
        this.updatedAt,
        this.updatedBy,
        this.userId});

  UserLocationId.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    customerData = json['customerData'];
    deletedAt = json['deletedAt'];
    deletedBy = json['deletedBy'];
    id = json['id'];
    isDefault = json['isDefault'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['address'] = address;
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['customerData'] = customerData;
    data['deletedAt'] = deletedAt;
    data['deletedBy'] = deletedBy;
    data['id'] = id;
    data['isDefault'] = isDefault;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['name'] = name;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['userId'] = userId;
    return data;
  }
}


// class Service {
//   String? createdAt;
//   String? createdBy;
//   String? customData;
//   String? deletedAt;
//   String? deletedBy;
//   int? id;
//   bool? isActive;
//   bool? isPopular;
//   String? nameEn;
//   String? nameTh;
//   String? updatedAt;
//   String? updatedBy;
//
//   Service(
//       {this.createdAt,
//         this.createdBy,
//         this.customData,
//         this.deletedAt,
//         this.deletedBy,
//         this.id,
//         this.isActive,
//         this.isPopular,
//         this.nameEn,
//         this.nameTh,
//         this.updatedAt,
//         this.updatedBy});
//
//   Service.fromJson(Map<String, dynamic> json) {
//     createdAt = json['createdAt'];
//     createdBy = json['createdBy'];
//     customData = json['customData'];
//     deletedAt = json['deletedAt'];
//     deletedBy = json['deletedBy'];
//     id = json['id'];
//     isActive = json['isActive'];
//     isPopular = json['isPopular'];
//     nameEn = json['nameEn'];
//     nameTh = json['nameTh'];
//     updatedAt = json['updatedAt'];
//     updatedBy = json['updatedBy'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['createdAt'] = this.createdAt;
//     data['createdBy'] = this.createdBy;
//     data['customData'] = this.customData;
//     data['deletedAt'] = this.deletedAt;
//     data['deletedBy'] = this.deletedBy;
//     data['id'] = this.id;
//     data['isActive'] = this.isActive;
//     data['isPopular'] = this.isPopular;
//     data['nameEn'] = this.nameEn;
//     data['nameTh'] = this.nameTh;
//     data['updatedAt'] = this.updatedAt;
//     data['updatedBy'] = this.updatedBy;
//     return data;
//   }
// }

// class UserLocationId {
//   String? address;
//   String? createdAt;
//   String? createdBy;
//   String? customerData;
//   Null? deletedAt;
//   Null? deletedBy;
//   int? id;
//   bool? isDefault;
//   String? latitude;
//   String? longitude;
//   String? name;
//   String? updatedAt;
//   Null? updatedBy;
//   int? userId;
//
//   UserLocationId(
//       {this.address,
//         this.createdAt,
//         this.createdBy,
//         this.customerData,
//         this.deletedAt,
//         this.deletedBy,
//         this.id,
//         this.isDefault,
//         this.latitude,
//         this.longitude,
//         this.name,
//         this.updatedAt,
//         this.updatedBy,
//         this.userId});
//
//   UserLocationId.fromJson(Map<String, dynamic> json) {
//     address = json['address'];
//     createdAt = json['createdAt'];
//     createdBy = json['createdBy'];
//     customerData = json['customerData'];
//     deletedAt = json['deletedAt'];
//     deletedBy = json['deletedBy'];
//     id = json['id'];
//     isDefault = json['isDefault'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     name = json['name'];
//     updatedAt = json['updatedAt'];
//     updatedBy = json['updatedBy'];
//     userId = json['userId'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['address'] = this.address;
//     data['createdAt'] = this.createdAt;
//     data['createdBy'] = this.createdBy;
//     data['customerData'] = this.customerData;
//     data['deletedAt'] = this.deletedAt;
//     data['deletedBy'] = this.deletedBy;
//     data['id'] = this.id;
//     data['isDefault'] = this.isDefault;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['name'] = this.name;
//     data['updatedAt'] = this.updatedAt;
//     data['updatedBy'] = this.updatedBy;
//     data['userId'] = this.userId;
//     return data;
//   }
// }

