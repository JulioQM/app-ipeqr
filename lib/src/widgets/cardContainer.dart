import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child;
  const CardContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // separacion a los lados
    return Padding(
      // en esta parte se puede bajar o subir el contenedor del login usando pading(all)
      //padding: EdgeInsets.all(30),
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.07), //30 por defecto
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        //  height: 300, //  BORRAR sirve para ver saber el tamaño
        //color: Colors.red,
        decoration: _createCardShape(),
        // en esta parte agrego el contenedor con las caracteristicas enviadas del loginPages
        child: this.child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15, // agregar tamaño de sombra a al contenerdor
            offset: Offset(0, 5), // sombra en eje x - y(- arriba + abajo)
          ),
        ],
      );
}
