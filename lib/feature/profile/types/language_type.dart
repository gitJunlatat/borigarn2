import 'package:borigarn/gen/assets.gen.dart';

enum LanguageType {
  en,
  th;

  AssetGenImage get icon {
    switch(this) {
      case LanguageType.en:
        return MyAssets.enIcon;
      case LanguageType.th:
        return MyAssets.thIcon;
    }
  }

  String get title {
    switch(this) {
      case LanguageType.en:
        return "English";
      case LanguageType.th:
        return "ไทย";
    }
  }
}