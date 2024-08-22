import 'package:flutter/material.dart';
import 'package:qr/pages/login_page.dart';
import '../services/user_preferences.dart';
import 'camara_qr.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _prefs =  UserPreferences();

  @override
  Widget build(BuildContext context) {
    return _prefs.isTokenActive() ? const CamaraQr() : const LoginPage();
  }
}
