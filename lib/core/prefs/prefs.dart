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

  String get getToken => _sharedPrefs.getString(tokenKey) ?? "";


  set loginType(String type) {
    _sharedPrefs.setString(loginKey, type);
  }

  String get loginType => _sharedPrefs.getString(loginKey) ?? "";

}

const String pakage = "borigarn";
const String tokenKey = "accessToken";
const String loginKey = "loginType";
