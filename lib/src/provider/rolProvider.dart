import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/routes/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RolProvider extends ChangeNotifier {
  Rol managerRol = new Rol();
  // metodo consulta
  Future<List<Rol>> getListaRol() async {
    try {
      var url = Uri.https(path.rutaEndPoint, path.pathRol);
      /* print(url); */
      var response = await http.get(url);
      // cogo los datos de la ruta
      var rol = json.decode(response.body)['roles'];
      // creo una lista de usuario
      List<Rol> roles = [];
      // recorro mi areglo de usuario
      for (var r in rol) {
        // ese usuario le agrego a mi mapa ,y itero
        roles.add(Rol.fromMap(r));
        print(rol);
      }
      /*  for (var item in roles) {
        print(item);
      } */
      return roles;
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }
}
