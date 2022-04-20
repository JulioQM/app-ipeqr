import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/routes/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// expediente se refiere al historial clinico de enfermedades
class ExpedienteProvider extends ChangeNotifier {
  Enfermedad managerExpediente = new Enfermedad();
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

  Future<RespuestaModel> registrarExpediente() async {
    try {
      var url = Uri.https(path.rutaEndPoint, path.pathEnfermedad);
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            "pers_id": managerExpediente.getPersId,
            "enfer_nombre": managerExpediente.getEnferNombre,
            "enfer_desc_medicacion": managerExpediente.getEnferDescMedicacion,
            "enfer_desc_dosificacion":
                managerExpediente.getEnferDescDosificacion,
            "enfer_desc_enfermedad": managerExpediente.getEnferDescEnfermedad
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
  Future<List<Enfermedad>> getListaExpediente({int busqueda}) async {
    try {
      var url = Uri.https(
          path.rutaEndPoint, path.pathEnfermedad + busqueda.toString());
      var response = await http.get(url);
      var expe = json.decode(response.body);
      print(expe);
      /*  Map<String, dynamic> users = {'expediente': expe[0]}; */
      Map<String, dynamic> users = {'expediente': expe};
      print(users);
      List<Enfermedad> exp = [];
      users.forEach((key, value) {
        exp.add(Enfermedad.fromMap(value));
      });
      return exp;
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }
}
