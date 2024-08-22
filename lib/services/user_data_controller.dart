import 'package:flutter/material.dart';
import '../models/profile_model.dart';
import 'user_preferences.dart';

class UserDataController {
  final _prefs = UserPreferences();

  initPrefs(ProfileModel profileModel) {
    _prefs.id = profileModel.profile.id;
    _prefs.nombre = profileModel.profile.nombre;
    _prefs.token = profileModel.accessToken;
  }

  clearPrefs() {
    _prefs.token = '';
    _prefs.id = '';
    _prefs.nombre = '';
    _prefs.email = '';
  }

  String getToken() => _prefs.token;
  int getId() => int.parse(_prefs.id);
  String getNombre() => _prefs.nombre;

  logOut(BuildContext context) async {
   await  clearPrefs();
  }

  logOutAndRedirect(BuildContext context) async {
    await logOut(context);
    Navigator.popAndPushNamed(context, 'login');
  }
}
