import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _preferences = UserPreferences._();
  SharedPreferences _prefs;

  UserPreferences._();

  factory UserPreferences() {
    return _preferences;
  }

  initPreferences() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  set setToken(String value) => this._prefs.setString('token', value);
  String get getToken => this._prefs.getString('token') ?? "";
}
