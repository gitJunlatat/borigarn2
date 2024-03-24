class CreateBookingPayload {
  int serviceId;
  String date;
  String time;
  bool isEstimate;
  String note;
  int price;
  String remark;
  int userLocationId;
  List<String> images;
  dynamic formFields;

  CreateBookingPayload({
    required this.serviceId,
    required this.userLocationId,
    required this.images,
    required this.date,
    required this.time,
    required this.isEstimate,
    required this.note,
    required this.price,
    required this.remark,
    required this.formFields,
  });

  Map<String, dynamic> toJson() => {
        'serviceId': serviceId,
    'userLocationId': userLocationId,
    'images': images,
    'date': date,
        'time': time,
        'isEstimate': isEstimate,
        'note': note,
        'price': price,
        'remark': remark,
        'formFields': formFields,
      };
}

class BookingFormField {
  int id;
  dynamic value;

  BookingFormField({
    required this.id,
    required this.value,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
      };
}

class BookingDateFormField {
  String date;
  String time;

  BookingDateFormField({
    required this.date,
    required this.time,
  });

  Map<String, dynamic> toJson() => {
        'date': date,
        'time': time,
      };
}
