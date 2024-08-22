import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance =  UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

   UserPreferences._internal();

  late SharedPreferences _prefs;

  set email(String email) {}

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  isTokenActive() {
    return _prefs.getString('token') != null && _prefs.getString('token') != "" ? true : false;
  }

  String get token {      
    return _prefs.getString('token') as dynamic ;
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  String get id {
    return _prefs.getString('id') ?? '' ;
  }

  set id(String value) {
    _prefs.setString('id', value.toString());
  }

  String get nombre {
    return _prefs.getString('nombre') ?? '' ;
  }

  set nombre(String value) {
    _prefs.setString('nombre', value.toString());
  }

}
