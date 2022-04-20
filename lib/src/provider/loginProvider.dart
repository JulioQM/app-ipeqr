import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/routes/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginProvider extends ChangeNotifier {
  Usuario managerUsuario = new Usuario();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  String email; // todo borar
  // simulacion de tiempo de espera backend
  bool _isLoading = false;
  bool loading = true;

  // vamos a crear get y set
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());
    print('$managerUsuario.getUsuaAlias - $managerUsuario.getUsuaClave');
    return formKey.currentState?.validate() ?? false;
  }

  // metodo para autenticacion de usuario administrador
  Future<RespuestaModel> autenticacionAdmin() async {
    try {
      _isLoading = true;
      notifyListeners();
      var url = Uri.https(path.rutaEndPoint, path.pathAutenticacionAdmin);
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            'usua_alias': managerUsuario.getUsuaAlias,
            'usua_clave': managerUsuario.getUsuaClave
          }));
      if (response.statusCode == 200) {
        return RespuestaModel(
          success: true,
          data: response.body,
          mensaje: json.decode(response.body)['message'],
        );
      } else
        return RespuestaModel(
          success: false,
          data: response.body,
          mensaje: json.decode(response.body)['message'],
        );
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }

// metodo para autenticacion de usuario normales
  Future<RespuestaModel> autentiacion() async {
    try {
      _isLoading = true;
      notifyListeners();
      var url = Uri.https(path.rutaEndPoint, path.pathAutenticacionUser);
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            'usua_alias': managerUsuario.getUsuaAlias,
            'usua_clave': managerUsuario.getUsuaClave,
          }));
      if (response.statusCode == 200) {
        return RespuestaModel(
          success: true,
          data: response.body,
          mensaje: json.decode(response.body)['message'],
        );
      } else
        return RespuestaModel(
          success: false,
          data: response.body,
          mensaje: json.decode(response.body)['message'],
        );
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }

  // metodo de verificación de código
  Future<RespuestaModel> verificarCodigo() async {
    try {
      _isLoading = true;
      notifyListeners();
      var url = Uri.https(path.rutaEndPoint, path.pathVerificarCodigo);
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            'usua_id': managerUsuario.getUsuaId,
            'usua_codigo': managerUsuario.getUsuaCodigo
          }));
      if (response.statusCode == 200) {
        return RespuestaModel(
          success: true,
          data: response.body,
          mensaje: json.decode(response.body)['message'],
        );
      } else
        return RespuestaModel(
          success: false,
          data: response.body,
          mensaje: json.decode(response.body)['message'],
        );
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }

  // metodo de enviar por email el código de verificación, para el cambio de clave
  Future<RespuestaModel> enviarCodigoEmail() async {
    try {
      _isLoading = true;
      notifyListeners();
      var url = Uri.https(path.rutaEndPoint, path.pathEnviarCodigoEmail);
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({'usua_email': managerUsuario.getUsuaEmail}));
      if (response.statusCode == 200) {
        return RespuestaModel(
          success: true,
          data: response.body,
          mensaje: json.decode(response.body)['message'],
        );
      } else
        return RespuestaModel(
          success: false,
          data: response.body,
          mensaje: json.decode(response.body)['message'],
        );
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }

  // metodo para cambiar de clave de cuenta de usuario
  Future<RespuestaModel> cambiarClave() async {
    try {
      _isLoading = true;
      notifyListeners();
      var url = Uri.https(path.rutaEndPoint, path.pathCambiarClave);
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            "usua_id": managerUsuario.getUsuaId,
            "usua_codigo_cambiar_clave":
                managerUsuario.getUsuaCodigoCambiarClave,
            "usua_clave": managerUsuario.getUsuaClave
          }));
      if (response.statusCode == 200) {
        return RespuestaModel(
          success: true,
          data: response.body,
          mensaje: json.decode(response.body)['message'],
        );
      } else
        return RespuestaModel(
          success: false,
          data: response.body,
          mensaje: json.decode(response.body)['message'],
        );
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }
}
