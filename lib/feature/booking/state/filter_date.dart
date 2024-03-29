import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/manager/network.dart';

part 'filter_date.g.dart';
@riverpod
class FilterDate extends _$FilterDate {
  @override
  DateTime? build() {
    return null;
  }

  void setDate(DateTime? date) {
    log.d('IS SETSTATE ${date}');
    state = date;
  }
}
