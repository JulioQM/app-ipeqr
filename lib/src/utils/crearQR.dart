import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// ESTE METODO ME CREAR EL CODIGO QR
class CrearQR {
  static Center addQR({int id}) {
    // antes en la linea 11 fecha 28-03-2022
    print('{' + '"' + 'id' + '":' + id.toString() + '}');
    return Center(
      child: QrImage(
        data: id.toString(),
        version: QrVersions.auto,
        size: 300,
        gapless: false,
        // esta parte se agrego recientemente 2022-04-2022
        /* embeddedImage: AssetImage('assets/logo4.png'),
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(80, 80),
        ), */
      ),
    );
  }

// version incompleta de metodo estatico de captura de codigo QR
// Version completa corriendo en la clase crearQR
  static QrPainter paint({String qrcode}) {
    final qrValidationResult = QrValidator.validate(
      data: qrcode,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    final qrCode = qrValidationResult.qrCode;
    return QrPainter.withQr(
      qr: qrCode,
      color: const Color(0xFF000000),
      gapless: true,
      embeddedImageStyle: null,
      embeddedImage: null,
    );
  }
}
