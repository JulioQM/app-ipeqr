import 'package:flutter/material.dart';

class ListaGenero {
  String opcionSelecionado;

  static List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<String> listaGenero = ['Masculino', 'Femenino'];
    List<DropdownMenuItem<String>> lista = [];
    listaGenero.forEach((genero) {
      lista.add(
        DropdownMenuItem(
          child: Text(genero),
          value: genero.contains('Masculino') ? 'M' : 'F',
        ),
      );
    });
    return lista;
  }
}
