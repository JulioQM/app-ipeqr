import 'package:flutter/material.dart';
import 'dart:io';

class FotoContainer extends StatelessWidget {
  final String url;
  const FotoContainer({Key key, this.url}) : super(key: key);
  @override
  // diseño deñ cuadro de la foto
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      // agrego el tamaño del contenedor
      height: size.height * 0.22,
      width: size.height * 0.22,
      child: Stack(
        children: <Widget>[
          Container(
            // agrego el tamaño del la bomba
            height: size.height * 0.22,
            width: size.height * 0.22,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.yellow[800], width: 0.5),
                borderRadius:
                    BorderRadius.circular(/* 95 */ size.height * 0.2)),
            child: ClipOval(
              child: getImage(picture: this.url),
            ),
          ),
          ClipOval(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                ),
                child: Icon(
                  Icons.add_a_photo_outlined,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// validaciones de la foto de perfil
  Widget getImage({String picture}) {
    try {
      if (picture == null) {
        print('Ejecutando imagen');
        return Image(
          image: AssetImage("assets/avatar_perfil.png"),
          fit: BoxFit.cover,
        );
      }
      if (picture.startsWith('http')) {
        print('Ejecutando imagen del end point');
        return FadeInImage(
          image: NetworkImage(picture),
          placeholder: AssetImage("assets/loading.gif"),
          fit: BoxFit.cover,
        );
      }
      return Image.file(
        File(picture),
        fit: BoxFit.cover,
      );
    } catch (e) {
      print("error.........." + e);
      return null;
    }
  }
}
