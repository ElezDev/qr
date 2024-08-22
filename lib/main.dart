import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'routes/routes.dart';
import 'services/user_preferences.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs =  UserPreferences();
  await prefs.initPrefs();
    await dotenv.load(fileName: ".env", mergeWith: {
    'TEST_VAR': '5',
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        initialRoute: '/',
        routes: getApplicationRoutes(),
      );
  }
}