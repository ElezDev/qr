import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../components/RAlert.dart';
import '../components/buttons/RaisedButtonComponent.dart';
import '../components/inputs/GenericTextInput.dart';
import '../models/profile_model.dart';
import '../providers/provider.dart';
import '../services/user_data_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final provider =  Provider();

  //bool _isLoading = false;
  bool _errorUsername = false;
  bool _errorPassword = false;

  final TextEditingController usernameController =
      TextEditingController(text: "");
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final userDataController = UserDataController();
  final RAlert rAlert = RAlert();

  validate() {
    setState(() {
      _errorUsername = false;
      _errorPassword = false;
    });
    if (usernameController.text.trim() == "") {
      setState(() => _errorUsername = true);
    }
    if (passwordController.text.trim() == "") {
      setState(() => _errorPassword = true);
    }
    if (_errorUsername || _errorPassword) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    logInCallback() async {
      if (validate()) return;
      Response response = await provider.login(
          email: usernameController.text, pass: passwordController.text);
      var dataRsp = jsonDecode(response.body);
      //print(dataRsp['nombre']);
      if (dataRsp['login'] == null) {
        rAlert.showError(
            context: context,
            desc: 'Este nombre de usuario no existe en nuestro sistema',
            title: 'Error');
      } else {
        Profile profile = Profile(
            id: dataRsp['codigo'],
            login: dataRsp['login'],
            nombre: dataRsp['nombre']);
        ProfileModel profileModel =
            ProfileModel(accessToken: dataRsp['codigo'], profile: profile);
        userDataController.initPrefs(profileModel);
        //print(profileModel.profile.nombre + "   ......");
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      }
    }

    Container buttonSection() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: RaisedButtonComponent(
            text: 'Iniciar sesión',
            textColor: dotenv.get('COLOR_PRIMARY').toString(),
            color: dotenv.get('COLOR_WHITE').toString(),
            elevation: 0.0,
            borderRadius: 25.0,
            onClick: logInCallback,
          ),
        );

    Container formSection() => Container(
      margin: const EdgeInsets.only(top: 120.0),
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 100.0),
              GenericTextInput(
                label: "Nombre de usuario",
                validation: _errorUsername,
                textValidation: 'Este campo es obligatorio',
                borderColor: "0XFF808080",
                borderWidth: 1.0,
                borderSideColor: "0XFF808080",
                borderSideWidth: 1.0,
                helperColor: "0XFF808080",
                labelColor: "0XFF808080",
                labelFontSize: 25.0,
                textInputType: TextInputType.text,
                colorStyle: "0XFF808080",
                cursorColor: "0XFF808080",
                controller: usernameController,
                obscureText: false,
                inputFormatter: FilteringTextInputFormatter.singleLineFormatter,
              ),
          const    SizedBox(height: 10.0),
              GenericTextInput(
                label: "Contraseña",
                validation: _errorPassword,
                textValidation: 'Este campo es obligatorio',
                borderColor: '0XFF808080',
                borderWidth: 1.0,
                borderSideColor: '0XFF808080',
                borderSideWidth: 1.0,
                helperColor: '0XFF808080',
                labelColor: '0XFF808080',
                labelFontSize: 25.0,
                textInputType: TextInputType.text,
                colorStyle: '0XFF808080',
                cursorColor: '0XFF808080',
                controller: passwordController,
                obscureText: true,
                inputFormatter: FilteringTextInputFormatter.singleLineFormatter,
              ),
           const   SizedBox(height: 80.0),
            ],
          ),
        );

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/fondo_login.png"), fit: BoxFit.cover),
        ),
        child: ListView(
          children: <Widget>[
            formSection(),
            buttonSection(),
          ],
        ),
      ),
    );
  }
}