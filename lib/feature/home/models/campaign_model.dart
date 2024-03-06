class CampaignModel {
  String? imageEn;
  String? imageTh;

  CampaignModel({
    this.imageEn, this.imageTh
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    return CampaignModel(
      imageEn: json['imageEn'],
      imageTh: json['imageTh'],
    );
  }
}
