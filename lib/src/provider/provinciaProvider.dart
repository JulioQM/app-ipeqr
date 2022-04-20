import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/routes/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProvinciaProvider extends ChangeNotifier {
  //Provincia managerProvincia = new Provincia();
  // metodo que extrae mis datos
  Future<List<Provincia>> getProvincias() async {
    try {
      var url = Uri.https(path.rutaEndPoint, path.pathProvincia);
      final response = await http.get(url);
      // cogo los datos de la ruta
      var provincia = json.decode(response.body);
      // creo una lista de provincia
      List<Provincia> prov = [];
      // recorro mi areglo de provincias
      for (var p in provincia) {
        // esas provincias le agrego a mi mapa ,y itero
        prov.add(Provincia.fromMap(p));
      }
      // imprimo la lista de solo nombres de provincias
      for (var p in prov) {
        print(p.provNombre);
      }
      // Retorno mi lista de provincias
      return prov;
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }
}
