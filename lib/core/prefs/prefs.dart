import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late SharedPreferences _sharedPrefs;

  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() => _instance;

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  bool isAuthentication() {
    return getToken.isNotEmpty;
  }

  set setToken(String token) {
    _sharedPrefs.setString(tokenKey, token);
  }

  set setUserId(int? id) {
    if(id == null) {
      _sharedPrefs.remove(userIdKey);
    }else {
      _sharedPrefs.setInt(userIdKey, id);

    }
  }

  String get getToken => _sharedPrefs.getString(tokenKey) ?? "";
  int? get getUserId => _sharedPrefs.getInt(userIdKey);


  set loginType(String type) {
    _sharedPrefs.setString(loginKey, type);
  }

  set setLocale(String locale) {
    _sharedPrefs.setString(loginKey, localeKey);
  }


  String get localeData => _sharedPrefs.getString(localeKey) ?? "en";

  String get loginType => _sharedPrefs.getString(loginKey) ?? "";

}

const String pakage = "borigarn";
const String tokenKey = "accessToken";
const String userIdKey = "userId";

const String loginKey = "loginType";
const String localeKey = "localeKey";
