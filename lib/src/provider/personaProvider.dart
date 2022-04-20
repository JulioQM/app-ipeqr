import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/routes/ruta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PersonaProvider extends ChangeNotifier {
  Persona managerPersona = new Persona();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  bool _isLoading = false;
  bool loding = true;
  bool get isLoading => _isLoading;
  bool get loading => loding;

  double _progress = 0;
  get downloadProgress => _progress;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set loading(bool value) {
    loding = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }

  Future<RespuestaModel> registrarPersona() async {
    try {
      var url = Uri.https(path.rutaEndPoint, path.pathPersona);
      print(url);
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            "usua_id": managerPersona.getUsuaId,
            "pers_identificacion":
                managerPersona.getPersIdentificacion, //si existe
            "pers_nombres": managerPersona.getPersNombres, //si existe
            "pers_apellidos": managerPersona.getPersApellidos, //si existe
            "pers_celular": managerPersona.getPersCelular, //si existe
            "pers_fecha_nacimiento":
                managerPersona.getPersFechaNacimiento, //si existe
            "pers_sexo": managerPersona.getPersSexo, //si existe
            "prov_id": managerPersona.getProvId, //si existe
            "ciud_id": managerPersona.getCiudId, //si existe
            "pers_direccion": managerPersona.getPersDireccion, //si existe
            /*  "pers_link_qr": managerPersona.getPersLinkQr, */
            /*  "pers_foto": managerPersona.getPersFoto */
          }));
      print('..........');
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
          mensaje: json.decode(response.body)['message'],
        );
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }

  Future<RespuestaModel> obtenerEntidad() async {
    try {
      var url = Uri.https(path.rutaEndPoint, path.pathPersonaValidador);
      print(url);
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            /* "usua_id": '1', */
            "pers_identificacion":
                managerPersona.getPersIdentificacion, //si existe
            "pers_nombres": managerPersona.getPersNombres, //si existe
            "pers_apellidos": managerPersona.getPersApellidos, //si existe
            "pers_celular": managerPersona.getPersCelular,
            "pers_sexo": managerPersona.getPersSexo,
            "pers_fecha_nacimiento": managerPersona.getPersFechaNacimiento
          }));
      print('..........');
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
          mensaje: json.decode(response.body)['errors'][0]['msg'],
        );
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }

  /// Visualizacion de perfil al momento de registrarse
  // metodo que extrae mis datos
  Future<List<Persona>> getListaPersona(int busqueda) async {
    try {
      var url = Uri.https(
          path.rutaEndPoint, path.pathPerfilJoin + busqueda.toString());
      print(url);
      var response = await http.get(url);
      Map<String, dynamic> user = jsonDecode(response.body);
      print(user);
      List<Persona> pers = [];
      user.forEach((key, value) {
        pers.add(Persona.fromMap(value));
      });
      return pers;
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }

  /// Visualizacion de perfil al momento de registrar una cuenta de usuario
  // metodo que extrae mis datos por el id de la persona
  Future<List<Persona>> getMostrarDatosRegistroPersona(int busqueda) async {
    try {
      var url = Uri.https(
          path.rutaEndPoint, path.pahtPerfilRegistro + busqueda.toString());
      print(url);
      var response = await http.get(url);
      Map<String, dynamic> user = jsonDecode(response.body);
      print(user);
      List<Persona> pers = [];
      user.forEach((key, value) {
        pers.add(Persona.fromMap(value));
      });
      print(response.body);
      if (response.statusCode == 200) {
        print('personas---------');
      }

      for (var item in pers) {
        print('........................d.s.dsd..s.d.s.d.s.d.s');
        print(item.getPersFoto);
        print(item.getPersApellidos);
        print(item.getPersNombres);
        print(item.getPersFoto);
        print(item.enferNombre);
      }
      return pers;
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }

  /// Visualizacion de perfil al momento de iniciar sesion
  // metodo que extrae mis datos por el id del usuario registrado
  Future<List<Persona>> getMostrarDatosAutenticacionPersona(
      int busqueda) async {
    try {
      var url = Uri.https(
          path.rutaEndPoint,
          /* path.pathHomeJoin */ path.pathPerfil + busqueda.toString());
      /* print(url); */
      var response = await http.get(url);
      Map<String, dynamic> user = jsonDecode(response.body);
      /* print(user); */
      List<Persona> pers = [];
      user.forEach((key, value) {
        pers.add(Persona.fromMap(value));
      });
      /* print(response.body); */
      if (response.statusCode == 200) {
        /* print('personas---------'); */
      }

      /*  for (var item in pers) {
        print('........................d.s.dsd..s.d.s.d.s.d.s');
        print(item.getPersFoto);
        print(item.getPersApellidos);
        print(item.getPersNombres);
        print(item.getPersFoto);
        print(item.enferNombre);
      } */
      return pers;
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }

  Future<RespuestaModel> actualizar() async {
    try {
      var url = Uri.https(path.rutaEndPoint, path.pathPersona + 2.toString());
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: jsonEncode({
            /* "pers_nombres": managerPersona.getPersNombres, //si existe
          "pers_apellidos": managerPersona.getPersApellidos, */
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

  // buscar código QR
  Future<List<int>> buscarCodigoQR() async {
    try {
      var url = Uri.https(path.rutaEndPoint, path.pathBuscarQR);
      print(url);
      var response = await http.get(url);
      List<int> idQR = [];
      var array = json.decode(response.body);
      /* print(array); */
      for (var item in array) {
        /* print(item); */
        idQR.add(item);
      }
      return idQR;
    } catch (e) {
      print(e.errorMessage());
      return null;
    }
  }
}
