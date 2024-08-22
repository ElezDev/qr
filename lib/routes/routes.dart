import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/main_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const MainPage(),
    'login': (BuildContext context) => const LoginPage(),
  };
}
