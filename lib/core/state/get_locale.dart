
import 'package:borigarn/feature/profile/types/language_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_locale.g.dart';

@Riverpod(keepAlive: true)
class GetLocale extends _$GetLocale {
  @override
  LanguageType build() {
    return LanguageType.th;
  }

  void setLocal(String locale) {
    if(locale == 'en') {
      state = LanguageType.en;

    }else {
      state = LanguageType.th;
    }
  }
}