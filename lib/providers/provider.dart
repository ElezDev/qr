import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../services/user_data_controller.dart';

class Provider {
  final String _url =
      dotenv.get('URL_BACKEND', fallback: 'Default fallback value');
  final userDataController = UserDataController();

  Future<http.Response> login(
      {required String email, required String pass}) async {
    var data = {"usuario": email, "password": pass};
    final response = await http.post(
        Uri.parse("https://d-estetico.co/tarjetade/api_login.php"),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'PHPSESSID=90198e07b37c52c040590a056ca646f7',
          'Authorization': 'D1R3CT0R103ST3T1C020210205'
        },
        body: jsonEncode(data));
    return response;
  }

  Future<http.Response> validarCogigo(
      {required int tipo, required String codigo}) async {
    var data = {"tipo": tipo, "codigo": codigo};
    final response = await http.post(
        Uri.parse("https://tarjetade.d-estetico.co/api_publicidad.php"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'D1R3CT0R103ST3T1C020210205'
        },
        body: jsonEncode(data));
    return response;
  }
}
