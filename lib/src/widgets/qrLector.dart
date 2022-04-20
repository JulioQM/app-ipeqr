import 'package:flutter/material.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/ar/exportAR.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class QRViewExample extends StatefulWidget {
  QRViewExample({Key key}) : super(key: key);

  @override
  _QRViewExampleState createState() => _QRViewExampleState();
}

String idQR = '';
List id = [];

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  bool bandera = false;
  QRViewController controller;
  // asigno a mi sample, el nombre que llevara en el entorno de realidad aumentada
  Sample sample = new Sample.fromJson({
    "required_extensions": ["geo"],
    "name": "Presenting Details",
    "path": "Show_AR/index.html",
    "requiredFeatures": ["geo"],
    "startupConfiguration": {
      "camera_position": "back",
      "camera_resolution": "auto"
    }
  });

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    final validarIdQR = Provider.of<PersonaProvider>(context, listen: false);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 5, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: Center(
              child: FutureBuilder<List<int>>(
                initialData: [],
                future: validarIdQR.buscarCodigoQR(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
                  List<int> pers = snapshot.data ?? [];
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  if (result != null) {
                    var code = id.elementAt(0);
                    print(code.runtimeType);
                    print('Imprimiendo codigo: ' + id.elementAt(0));
                    // expresiones regulares para que permita solo numero sin caracteres especiales
                    String pattern = "[^\\d,\\d]";
                    RegExp regExp = new RegExp(pattern);
                    String value = code;
                    var bandera = regExp.hasMatch(value);
                    if (bandera) {
                      // incorrecto, en caso que no sea numero
                      print('incorrecto');
                      return Text('Escanea un código QR válido!');
                    } else {
                      // correcto, acepta solo numeros
                      print('correcto, solo numero');
                      var entero = int.parse(code);
                      if (pers.contains(entero)) {
                        return MaterialButton(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0)),
                          onPressed: () async {
                            await pushArView(sample, entero);
                          },
                          color: Colors.deepPurple,
                          child: Text(
                            'Ver información',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        );
                      } else {
                        return Text('Escanea un código QR válido!');
                      }
                    }
                  }
                  return Text('Escanea un código QR!');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      idQR = result.code;
      print('.......................');
      print(idQR);
      print('.......................');
      id = [idQR];
      print(id);
      print('.......................');
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<WikitudeResponse> isDeviceSupporting(List<String> features) async {
    return await WikitudePlugin.isDeviceSupporting(features);
  }

  Future<WikitudeResponse> _requestARPermissions(List<String> features) async {
    return await WikitudePlugin.requestARPermissions(features);
  }

  Future<void> pushArView(Sample sample, var id) async {
    WikitudeResponse permissionsResponse =
        await _requestARPermissions(sample.requiredFeatures);
    if (permissionsResponse.success) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ArViewWidget(sample: sample, id: id)),
      );
    } else {
      _showPermissionError(permissionsResponse.message);
    }
  }

  void _showPermissionError(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Permissions required"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Open settings'),
              onPressed: () {
                Navigator.of(context).pop();
                WikitudePlugin.openAppSettings();
              },
            )
          ],
        );
      },
    );
  }
}
