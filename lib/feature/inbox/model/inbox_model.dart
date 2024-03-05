import 'package:freezed_annotation/freezed_annotation.dart';

part 'inbox_model.freezed.dart';
part 'inbox_model.g.dart'; // JSON serialization

@freezed
class InboxModel with _$InboxModel {
  const InboxModel._();
  const factory InboxModel({
    required String modShopId,
    required String shopName,
    required String modProductId,
    required String productImageUrl,

  }) = _InboxModel;

  factory InboxModel.fromJson(Map<String, dynamic> json) => _$InboxModelFromJson(json);

}
