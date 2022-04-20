import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/utils/responsive.dart';
import 'package:fronted_lookhere/src/widgets/qrLector.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    /* const Color blue1 = Color.fromRGBO(222, 1, 162, 0.7); */
    return FloatingActionButton(
      /* foregroundColor: blue1, */
      elevation: 0,
      // Sirve para agregarle un sombreado al boton
      child: Icon(
        Icons.qr_code_scanner,
        size: responsive.diagonalp(3.7),
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => QRViewExample(),
            ),
            (route) => true);
        /*  Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QRViewExample(),
        )); */
      },
    );
  }
}
