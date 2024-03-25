import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/manager/network.dart';
part 'booking_image_picker.g.dart';

@Riverpod(keepAlive: true)
class BookingImagePicker extends _$BookingImagePicker {
  @override
  List<XFile> build() {
    return [];
  }

  void setImage(List<XFile> images) {
    state = images;
  }
}

