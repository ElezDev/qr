import 'dart:async';
import 'dart:convert';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import '../components/RAlert.dart';
import '../providers/provider.dart';
import '../services/user_data_controller.dart';

class CamaraQr extends StatefulWidget {
  const CamaraQr({super.key});
  @override
  _CamaraQrState createState() => _CamaraQrState();
}

class _CamaraQrState extends State<CamaraQr> {
  ScanResult? scanResult;

  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');
  final provider = Provider();
  final RAlert rAlert = RAlert();
  final userDataController = UserDataController();

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final scanResult = this.scanResult;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
              backgroundColor: const Color.fromARGB(212, 118, 174, 238),
              title: const Text('Inicio')),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(userDataController.getNombre().toString()),
                  accountEmail: const Text(""),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(212, 118, 174, 238),
                  ),
                ),
                Ink(
                  color: const Color.fromARGB(212, 118, 174, 238),
                  child: const ListTile(
                    title: Text(
                      "Validar código QR",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text("Cerrar sesion"),
                  onTap: () async {
                    userDataController.logOutAndRedirect(context);
                  },
                ),
              ],
            ),
          ),
          body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/fondo_qr.png"), fit: BoxFit.cover),
            ),
            child: ListView(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.4),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color.fromARGB(308, 179, 87, 167),
                        Color.fromARGB(212, 118, 174, 238)
                      ])),
                      child: ElevatedButton(
                        onPressed: _scan,
                        child: const Text('Abrir camara'),
                      ),
                    ))
              ],
            ),
          )),
    );
  }

  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: -1,
          autoEnableFlash: false,
          android: const AndroidOptions(
            aspectTolerance: 0.00,
            useAutoFocus: true,
          ),
        ),
      );
      if (result.type.toString() == "Barcode") {
        if (result.format.toString() == "qr") {
          Response response =
              await provider.validarCogigo(tipo: 2, codigo: result.rawContent);
          var dataRsp = jsonDecode(response.body);
          if (dataRsp['codigo'] == 0) {
            rAlert.showError(
                context: context, desc: dataRsp['mensaje'], title: 'Error');
          } else {
            rAlert.showError(
                context: context,
                desc: dataRsp['mensaje'],
                title: 'Información');
          }
        } else {
          Response response =
              await provider.validarCogigo(tipo: 1, codigo: result.rawContent);
          var dataRsp = jsonDecode(response.body);
          if (dataRsp['codigo'] == 0) {
            rAlert.showError(
                context: context, desc: dataRsp['mensaje'], title: 'Error');
          } else {
            rAlert.showError(
                context: context,
                desc: dataRsp['mensaje'],
                title: 'Información');
          }
        }
      }

      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
  }
}
