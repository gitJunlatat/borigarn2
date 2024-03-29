import 'package:freezed_annotation/freezed_annotation.dart';

class InboxModel {
  String? createdAt;
  String? createdBy;
  String? deletedAt;
  String? deletedBy;
  int? id;
  String? imageEn;
  String? imageTh;
  bool? isRead;
  String? nameEn;
  String? nameTh;
  int? reservationId;
  String? type;
  String? updateStatus;
  String? updatedAt;
  String? updatedBy;
  int? userId;


  InboxModel(
      {this.createdAt,
        this.createdBy,
        this.deletedAt,
        this.deletedBy,
        this.id,
        this.imageEn,
        this.imageTh,
        this.isRead,
        this.nameEn,
        this.nameTh,
        this.reservationId,
        this.type,
        this.updateStatus,
        this.updatedAt,
        this.updatedBy,
        this.userId});

  InboxModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    deletedAt = json['deletedAt'];
    deletedBy = json['deletedBy'];
    id = json['id'];
    imageEn = json['imageEn'];
    imageTh = json['imageTh'];
    isRead = json['isRead'];
    nameEn = json['nameEn'];
    nameTh = json['nameTh'];
    reservationId = json['reservationId'];
    type = json['type'];
    updateStatus = json['update_status'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['createdAt'] = createdAt;
    data['createdBy'] = createdBy;
    data['deletedAt'] = deletedAt;
    data['deletedBy'] = deletedBy;
    data['id'] = id;
    data['imageEn'] = imageEn;
    data['imageTh'] = imageTh;
    data['isRead'] = isRead;
    data['nameEn'] = nameEn;
    data['nameTh'] = nameTh;
    data['reservationId'] = reservationId;
    data['type'] = type;
    data['update_status'] = updateStatus;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    data['userId'] = userId;
    return data;
  }
}