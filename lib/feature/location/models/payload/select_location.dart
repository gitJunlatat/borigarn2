class SelectLocation {
  double lat;
  double long;
  String placeName;
  String address;
  String administrativeArea;
  bool isDefault;
  String? landmark;

  SelectLocation({required this.lat, required this.long, required this.placeName, required this.address, required this.administrativeArea, required this.isDefault, this.landmark});
}
