import 'package:borigarn/core/manager/network.dart';
import 'package:borigarn/core/utils/date.dart';
import 'package:borigarn/feature/home/models/payload/create_booking_payload.dart';
import 'package:borigarn/feature/home/models/service_detail.dart';
import 'package:borigarn/feature/home/types/select_form_type.dart';
import 'package:borigarn/feature/home/types/service_type.dart';
import 'package:borigarn/feature/profile/types/language_type.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get/get.dart';

// @freezed

part 'service_model.freezed.dart';

part 'service_model.g.dart';

@freezed
class Service with _$Service {
  const Service._();

  const factory Service({
    int? id,
    String? createdAt,
    String? updatedAt,
    String? createdBy,
    String? updatedBy,
    String? deletedAt,
    String? deletedBy,
    String? nameTh,
    String? nameEn,
    bool? isPopular,
    bool? isActive,
    String? customData,
    String? descriptionTh,
    String? descriptionEn,
    List<ServiceDetails>? details,
    String? result,
  }) = _Service;

  factory Service.fromJson(Map<String, dynamic> json) => _$ServiceFromJson(json);

  Service deepCopy() {
    return copyWith(details: details, result: result);
  }

  String? getName(LanguageType type) {
    if (type == LanguageType.en) {
      return nameEn;
    } else {
      return nameTh;
    }
  }

  String? getDescription(LanguageType type) {
    if (type == LanguageType.en) {
      return descriptionEn;
    } else {
      return descriptionTh;
    }
  }

  int? getCost() {
    switch (id?.toServiceType()) {
      case ServiceType.maidService:
        if (details == null) {
          return 0;
        }
        printWrapped("TIME ${details?.where((e) => [5].contains(e.id)).toList()}");

        final numberCleaner = details?.firstWhereOrNull((element) => element.id == 2)?.selected.firstOrNull?.value ?? 0;
        final priceWorkTime = details?.firstWhereOrNull((element) => element.id == 3)?.selected.firstOrNull?.value ?? 0;

        final extraService = details?.firstWhereOrNull((element) => element.id == 6)?.selected.map((e) => e.value ?? 0).toList() ?? [];
        log.e(extraService);
        final totalExtraService = (extraService.isNotEmpty) ? extraService.reduce((value, element) => value + element) : 0;
        log.e(totalExtraService);

        return (numberCleaner * priceWorkTime) + (numberCleaner * totalExtraService);
      default:
        return 0;
    }
  }

  CreateBookingPayload createPayload(LanguageType locale, int locationId) {
    switch (id?.toServiceType()) {
      case ServiceType.maidService:

        final note = details?.where((element) => [7].contains(element.id)).toList().firstOrNull?.result ?? '';
        final dateTimePicked = details?.firstWhereOrNull((element) => [5].contains(element.id));
        final date = DateAction.getDateStringFormattedPayload(dateTimePicked?.date ?? DateTime.now());
        final time = "${dateTimePicked?.time ?? ''}:00";

        final choice = details?.where((element) => [39, 1, 2, 3, 4].contains(element.id)).map((e) {
              return BookingFormField(id: e.id!, value: e.selected.first.value ?? e.selected.first.getName(locale) ?? '');
            }).toList() ??
            [];

        final multiChoice = details?.where((element) => [6].contains(element.id)).map((e) {
              return BookingFormField(id: e.id!, value: '${e.selected.map((e) => e.value ?? 0)}');
            }).toList() ??
            [];

        final textArea = details?.where((element) => [40].contains(element.id)).map((e) {
              return BookingFormField(id: e.id!, value: e.result);
            }).toList() ??
            [];
        final allForm = choice + textArea + multiChoice;
        print("ALLRESULT");

        final resultFormField = allForm.map((e) => e.toJson()).toList();
        print(resultFormField);

        return CreateBookingPayload(serviceId: id!, userLocationId: locationId, date: date, time: time, isEstimate: true, note: note, price: getCost() ?? 0, remark: note, formFields: resultFormField, images: []);
      default:
        return CreateBookingPayload(serviceId: id!, userLocationId: locationId, date: '', time: '', isEstimate: true, note: '', price: 0, remark: '', formFields: [], images: []);
    }
  }

  String? validate(LanguageType lang) {
    switch (id?.toServiceType()) {
      case ServiceType.maidService:
        final focusIds = [39, 1, 40, 2, 3, 4, 5];
        final focusItem = details?.where((e) => focusIds.contains(e.id)).toList();
        final itemNotFill = focusItem?.where((element) {
          return element.selected.isEmpty && element.result == null && element.date == null && element.time == null;
        }).toList();

        if ((itemNotFill?.length ?? 0) == 0) {
          return null;
        } else {
          return itemNotFill?.first.getText(lang);
        }

      case ServiceType.laundryService:
        final focusIds = [8, 9, 10, 11];
        final focusItem = details?.where((e) => focusIds.contains(e.id)).toList();
        final itemNotFill = focusItem?.where((element) {
          return element.selected.isEmpty && element.result == null;
        }).toList();

        if ((itemNotFill?.length ?? 0) == 0) {
          return null;
        } else {
          return itemNotFill?.first.getText(lang);
        }

      default:
        return null;
    }
  }
}
