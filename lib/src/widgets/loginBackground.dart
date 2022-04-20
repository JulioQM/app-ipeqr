import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  // esta variable es asignada para agregar otros parametros a este widget, en este caso sirve para crear un contenedor ,
  // la cual se esta asignando sus caracatericas en clase que se le esta convocando o utilizando
  final Widget child;
  // requiered
  const LoginBackground({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /* color: Colors.red, */
      width: double.infinity,
      height: double.infinity,
      // stack sirve como columna de separacion de widget
      child: Stack(
        children: <Widget>[
          _ColorCaja(),
          _IconoLogin(),
          this.child,
        ],
      ),
    );
  }
}

class _ColorCaja extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // variable que coge todo el tamaño de pantalla
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      // se refiere al 40% de la zona vertical de la pantalla
      height: size.height * 0.4,
      /*  color: Colors.indigo, */
      decoration: _colorCaja(),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: _EfectoBurbuja(),
            bottom: -40,
            left: -20,
          ),
          Positioned(
            child: _EfectoBurbuja(),
            top: -30,
            left: -40, // el fet va a la derecha en (+)
          ),
          Positioned(
            child: _EfectoBurbuja(),
            top: -40, // +baja -sube
            right: 40, //el right va a la isquierda en (+)
          ),
          Positioned(
            child: _EfectoBurbuja(),
            top: 50, // +baja -sube
            left: 50, //el right va a la isquierda en (+)
          ),
          Positioned(
            child: _EfectoBurbuja(),
            top: 180, // +baja -sube
            left: 150, //el right va a la isquierda en (+)
          ),
          Positioned(
            child: _EfectoBurbuja(),
            top: 90, // +baja -sube
            right: 50, //el right va a la isquierda en (+)
          ),
          Positioned(
            child: _EfectoBurbuja(),
            bottom: -35, // +sube - baja
            right: -25, //el right va a la isquierda en (+)
          )
        ],
      ),
    );
  }

// metodo para crear el color personalizado de la caja
  BoxDecoration _colorCaja() => BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(63, 63, 156, 1),
          Color.fromRGBO(90, 70, 178, 1),
        ]),
      );
}

// metodo para crear el efecto burbuja
class _EfectoBurbuja extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.05),
      ),
    );
  }
}

class _IconoLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // Safearea sirve para dar un espacio entre el noch que vendria hacer la barra superior del appbar
      child: Container(
        // sirve para ver el cuadro de mi container
        width: double.infinity,
        height: 100,
        //color: Colors.red,
        // margin: EdgeInsets.all(100),
        margin: EdgeInsets.only(top: 20),

        child: Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
