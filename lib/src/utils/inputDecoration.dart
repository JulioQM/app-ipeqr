// no es Widget
import 'package:flutter/material.dart';

// metodo estatic, y hacer referencia a a la propiedad InputDecoration
class InputDecorations {
  static InputDecoration inputDecoration({
    // parametros obligatorios de la propiedad
    String hintText,
    String labelText,
    IconData prefixIcon,
    // nuevo icono a la derecha
    Widget suffixIcon,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple, // color linea
          width: 1.9, // grosor de la linea
        ),
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.grey), // color titulo textbox
      prefixIcon: Icon(
        prefixIcon, color: Colors.deepPurple, // cambio el color
      ),
      // agregago nuevo 26-03-2022
      suffixIcon: suffixIcon,
    );
  }
}
