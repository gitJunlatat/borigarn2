import 'package:borigarn/feature/profile/types/language_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_response_model.freezed.dart';
part 'booking_response_model.g.dart';

@freezed
class BookingResponseModel with _$BookingResponseModel {
  const BookingResponseModel._();
  const factory BookingResponseModel(
      {
        int? id,
        int? userLocationId,
        List<String>? images,
        String? date,
        String? time,
        String? number,
        int? price,
        int? userId,


      }) = _BookingResponseModel;

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) => _$BookingResponseModelFromJson(json);

  // String? getName(LanguageType type) {
  //   if(type == LanguageType.en) {
  //     return nameEn;
  //   }else {
  //     return nameTh;
  //   }
  // }
  //
  // String? getDescription(LanguageType type) {
  //   if(type == LanguageType.en) {
  //     return descriptionEn;
  //   }else {
  //     return descriptionTh;
  //   }
  // }

}