import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'dart:io';

class ButtonDescargar extends StatefulWidget {
  /* final String id; */ //antes
  final int id;
  const ButtonDescargar({Key key, this.id}) : super(key: key);

  @override
  _ButtonDescargarState createState() => _ButtonDescargarState();
}

class _ButtonDescargarState extends State<ButtonDescargar> {
  @override
  Widget build(BuildContext context) {
    //Create an instance of ScreenshotController
    ScreenshotController screenshotController = ScreenshotController();
    return Center(
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Screenshot(
        controller: screenshotController,
        child: Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius:
                          10, // agregar tamaño de sombra a al contenerdor
                      offset:
                          Offset(0, 5), // sombra en eje x - y(- arriba + abajo)
                    ),
                  ],
                ),
                child: QrImage(
                  data: this.widget.id.toString(),
                  version: QrVersions.auto,
                  size: 200,
                  gapless: false,
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Text('¡Conóceme aquí!')
            ],
          ),
        ),
      ),
      /*  SizedBox(
        height: 25,
      ), */
      MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.deepPurple,
        elevation: 3,
        child: Text(
          'Descargar QR',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () {
          print(screenshotController);
          screenshotController
              .capture(delay: Duration(milliseconds: 10))
              .then((capturedImage) async {
            await screenshotController
                .capture(delay: const Duration(milliseconds: 10))
                .then((Uint8List image) async {
              if (image != null) {
                final directory = await getApplicationDocumentsDirectory();
                final imagePath =
                    await File('${directory.path}/image.png').create();
                await imagePath.writeAsBytes(image);
                final result = await ImageGallerySaver.saveImage(image);
                print(result);
                _toastInfo('Imagen guardada en galeria');
              }
            });
          }).catchError((onError) {
            print(onError);
          });
        },
      ),
    ])));
  }

  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }

  Future<void> writeToFile(ByteData data, String path) async {
    try {
      print('comenzando metodo writeFile');
      var buffer = data.buffer;
      await File(path).writeAsBytes(
          buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
      print(path);
    } catch (e) {
      print(e);
    }
  }
}
