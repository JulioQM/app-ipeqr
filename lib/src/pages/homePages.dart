import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/utils/responsive.dart';
import 'package:fronted_lookhere/src/utils/scanButton.dart';

class BienvenidaPages extends StatefulWidget {
  @override
  _BienvenidaPagesState createState() => _BienvenidaPagesState();
}

class _BienvenidaPagesState extends State<BienvenidaPages> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: responsive.altop(20)),
          child: Column(
            children: [
              Container(
                /*  color: Colors.amber, */
                child: Text(
                  '¡Bienvenido!',
                  style: TextStyle(
                    fontSize: responsive.diagonalp(5),
                    color: Colors.black,
                  ),
                ),
                margin: EdgeInsets.only(bottom: 10),
              ),
              Container(
                /* color: Colors.amber, */
                child: Image(
                  image: AssetImage("assets/logo6.png"),
                  fit: BoxFit.cover,
                  width: responsive.diagonalp(20),
                ),
              ),
              Divider(
                color: Colors.transparent,
                height: responsive.altop(4),
              ),
              Container(
                child: Text(
                  'Ingresar a tu cuenta',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: responsive.diagonalp(2.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Divider(
                color: Colors.transparent,
                height: responsive.altop(4),
              ),
              Container(
                width: responsive.diagonalp(38),
                height: responsive.altop(12),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'login', (route) => true);
                  },
                  color: Colors.deepPurple,
                  child: Text(
                    '¿Ya eres usuario? Iniciar Sesión',
                    style: TextStyle(fontSize: responsive.diagonalp(1.8)),
                  ),
                  elevation: 1,
                  textColor: Colors.white,
                ),
              ),
              Divider(
                color: Colors.transparent,
                height: responsive.altop(4),
              ),
              Container(
                width: responsive.diagonalp(38),
                height: responsive.altop(12),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'usuario', (route) => true);
                  },
                  color: Colors.deepPurple,
                  child: Text(
                    '¿No tienes cuenta? Registrarse',
                    style: TextStyle(fontSize: responsive.diagonalp(1.8)),
                  ),
                  elevation: 0,
                  textColor: Colors.white,
                ),
              ),
              Divider(
                color: Colors.transparent,
                height: responsive.altop(4),
              ),
              Container(
                width: responsive.diagonalp(38),
                height: responsive.altop(12),
                child: MaterialButton(
                  splashColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'loginAdmin', (route) => true);
                  },
                  color: Colors.indigo,
                  child: Text(
                    'Iniciar como administrador',
                    style: TextStyle(fontSize: responsive.diagonalp(1.8)),
                  ),
                  elevation: 0,
                  textColor: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: responsive.altop(12)),
                /*  color: Colors.amber, */
                child: Text(
                  'Escanea el QR\naqui abajo!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: responsive.diagonalp(2.3),
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
        // en este apartado agrego el icono de Scaneo y ademas centro el icono
        floatingActionButton: ScanButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[50],
        /* Color.fromRGBO(0, 68, 69, .5)  */
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        title: Text(
          "Confirmar",
          textAlign: TextAlign.center,
        ),
        content: Text("¿Deseas salir de la aplicación?"),
        actions: <Widget>[
          TextButton(
            child: Text(
              'No',
              style: TextStyle(color: Colors.deepPurple),
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text(
              'Si',
              style: TextStyle(color: Colors.deepPurple),
            ),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }
}
