import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/routes/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FamiliaProvider extends ChangeNotifier {
  Familiar managerFamiliar = new Familiar();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }

  Future<RespuestaModel> registrarFamiliar() async {
    try {
      var url = Uri.https(path.rutaEndPoint, path.pathFamiliar);
      print(url);
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            "pers_id": managerFamiliar.getPersId,
            "famil_nombres": managerFamiliar.getFamilNombres,
            "famil_apellidos": managerFamiliar.getFamilApellidos,
            "famil_celular": managerFamiliar.getFamilCelular,
            /* "famil_convencional": managerFamiliar.getFamilConvencional, */
            "famil_direccion": managerFamiliar.getFamilDireccion
          }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return RespuestaModel(
          success: true,
          data: response.body,
          mensaje: json.decode(response.body)['msg'],
        );
      } else
        return RespuestaModel(
          success: false,
          data: response.body,
          mensaje: json.decode(response.body)['msg'],
        );
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }

  // consultar familiar
  Future<List<Familiar>> getListaFamiliar({int busqueda}) async {
    try {
      var url =
          Uri.https(path.rutaEndPoint, path.pathFamiliar + busqueda.toString());
      print(url);
      var response = await http.get(url);
      Map<String, dynamic> user = jsonDecode(response.body);
      print(user);
      /* Map<String, dynamic> users = {'familiar': user['familiar'][0]}; */
      //Map<String, dynamic> users = {'familiar': user};
      //print(users);
      List<Familiar> famil = [];
      user.forEach((key, value) {
        famil.add(Familiar.fromMap(value));
      });
      for (var item in famil) {
        print(item.familNombres);
      }
      return famil;
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }

  // consultar familiar por persona ID
  Future<List<Familiar>> getListaFamiliarIdPersona({int busqueda}) async {
    try {
      var url = Uri.https(
          path.rutaEndPoint, path.pathFamiliarIdPersona + busqueda.toString());
      print(url);
      var response = await http.get(url);
      var famil = json.decode(response.body)['familiar'];
      print(famil);
      List<Familiar> familiares = [];
      for (var f in famil) {
        familiares.add(Familiar.fromMap(f));
      }
      for (var item in familiares) {
        print(item.familNombres);
      }
      return familiares;
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }
}
