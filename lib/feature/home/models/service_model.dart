class Service {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? deletedAt;
  String? deletedBy;
  String? nameTh;
  String? nameEn;
  bool? isPopular;
  bool? isActive;
  String? customData;
  List<ServiceDetails>? details;

  Service(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedAt,
        this.deletedBy,
        this.nameTh,
        this.nameEn,
        this.isPopular,
        this.isActive,
        this.customData,
        this.details});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedAt = json['deletedAt'];
    deletedBy = json['deletedBy'];
    nameTh = json['nameTh'];
    nameEn = json['nameEn'];
    isPopular = json['isPopular'];
    isActive = json['isActive'];
    customData = json['customData'];
    if (json['details'] != null) {
      details = <ServiceDetails>[];
      json['details'].forEach((v) {
        details!.add(ServiceDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['deletedAt'] = deletedAt;
    data['deletedBy'] = deletedBy;
    data['nameTh'] = nameTh;
    data['nameEn'] = nameEn;
    data['isPopular'] = isPopular;
    data['isActive'] = isActive;
    data['customData'] = customData;
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceDetails {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? deletedAt;
  String? deletedBy;
  String? textTh;
  String? textEn;
  String? type;
  int? order;
  List<Service>? items;

  ServiceDetails(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedAt,
        this.deletedBy,
        this.textTh,
        this.textEn,
        this.type,
        this.order,
        this.items});

  ServiceDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedAt = json['deletedAt'];
    deletedBy = json['deletedBy'];
    textTh = json['textTh'];
    textEn = json['textEn'];
    type = json['type'];
    order = json['order'];
    if (json['items'] != null) {
      items = <Service>[];
      json['items'].forEach((v) {
        items!.add(Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['deletedAt'] = deletedAt;
    data['deletedBy'] = deletedBy;
    data['textTh'] = textTh;
    data['textEn'] = textEn;
    data['type'] = type;
    data['order'] = order;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemsDetail {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;
  String? deletedAt;
  String? deletedBy;
  String? nameTh;
  String? nameEn;
  String? descriptionTh;
  String? descriptionEn;
  int? value;
  bool? isPopular;
  bool? isAppraise;
  bool? isActive;

  ItemsDetail(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedAt,
        this.deletedBy,
        this.nameTh,
        this.nameEn,
        this.descriptionTh,
        this.descriptionEn,
        this.value,
        this.isPopular,
        this.isAppraise,
        this.isActive});

  ItemsDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    deletedAt = json['deletedAt'];
    deletedBy = json['deletedBy'];
    nameTh = json['nameTh'];
    nameEn = json['nameEn'];
    descriptionTh = json['descriptionTh'];
    descriptionEn = json['descriptionEn'];
    value = json['value'];
    isPopular = json['isPopular'];
    isAppraise = json['isAppraise'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    data['deletedAt'] = deletedAt;
    data['deletedBy'] = deletedBy;
    data['nameTh'] = nameTh;
    data['nameEn'] = nameEn;
    data['descriptionTh'] = descriptionTh;
    data['descriptionEn'] = descriptionEn;
    data['value'] = value;
    data['isPopular'] = isPopular;
    data['isAppraise'] = isAppraise;
    data['isActive'] = isActive;
    return data;
  }
}