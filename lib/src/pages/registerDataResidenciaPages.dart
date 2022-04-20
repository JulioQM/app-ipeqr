import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/personasArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class RegisterResidenciaPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: LoginBackground(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: /* 150 */ responsive.altop(35)),
                CardContainer(
                  // llamo mi widget contenedor
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: /* 10 */ responsive.altop(5)),
                      Text(
                        'Ingresa tus datos de residencia',
                        textAlign: TextAlign.center,
                        style: /* Theme.of(context).textTheme.headline6 */ TextStyle(
                            fontSize: responsive.diagonalp(2.8),
                            color: Colors.black45),
                      ),
                      SizedBox(height: /* 10 */ responsive.altop(5)),
                      ChangeNotifierProvider(
                        // crea una instancia changeNotifierProvider
                        create: (_) => PersonaProvider(),
                        child: _FormularioRegister(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: /* 10 */ responsive.altop(2.5)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

int idPersona;

class _FormularioRegister extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // con esta variable puedo ingresar a la instancia de la clase PersonaProvider y UsuarioProvider
    final personaForm = Provider.of<PersonaProvider>(context);
    final usuarioForm = Provider.of<UsuarioProvider>(context);
    final Responsive responsives = Responsive.of(context);
    return Container(
      child: Form(
        key: personaForm.formKey,
        // activar validacion en modo de interacion
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            // combobox  para el atributo provincia y ciudades
            FutureBuilderLocalidad(),

            /* BuildersCiudad(), */
            /* SizedBox(height: 20), */
            TextFormField(
              autocorrect: true,
              keyboardType: TextInputType.text,
              inputFormatters: [UpperCaseTextFormatter()],
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Dirección',
                  hintText: 'Ingrese su dirección',
                  prefixIcon: Icons.house_outlined),
              // agrego el valor de las cajas de texto a las propiedades del provider personas
              onChanged: (value) =>
                  personaForm.managerPersona.setPersDireccion = value.trim(),
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'La dirección es obligatoria';
              },
            ),
            SizedBox(height: /* 30 */ responsives.altop(5)),
            // boton de continuar o siguiente registro
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              minWidth: responsives.anchop(30),
              height: responsives.altop(12),
              child: Text(
                personaForm.isLoading ? 'Espere' : 'Siguiente',
                style: TextStyle(
                    color: Colors.white, fontSize: responsives.diagonalp(1.6)),
              ),
              onPressed: personaForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus(); // bloquea mi boton
                      if (!personaForm.isValidForm()) return;
                      personaForm.isLoading = true;
                      // llamo a mis parametros de otras clases como usuario y primera parte de identificacion
                      final IdentidadArguments argPersona =
                          ModalRoute.of(context).settings.arguments;
                      print('..........................');
                      print(argPersona.alias);
                      print(argPersona.correo);
                      print(argPersona.clave);
                      print(argPersona.cedula);
                      print(argPersona.nombres);
                      print(argPersona.apellidos);
                      print(argPersona.fechaNacimiento);
                      print(argPersona.genero);
                      print(argPersona.telefono);
                      print('..........................');

                      // constructor enviando valores a usuario
                      Usuario(
                          usuaAlias: usuarioForm.managerUsuario.setUsuaAlias =
                              argPersona.alias,
                          usuaEmail: usuarioForm.managerUsuario.setUsuaEmail =
                              argPersona.correo,
                          usuaClave: usuarioForm.managerUsuario.setUsuaClave =
                              argPersona.clave);
                      // metodo agregar usuario
                      RespuestaModel usuario =
                          await usuarioForm.registrarUsuario();
                      // deserealizo el valor devuelto por el metodo registrar usuario
                      Map<String, dynamic> user = jsonDecode(usuario.data);
                      print(user['id']);
                      // constructor enviando valores a persona
                      Persona(
                          usuaId: personaForm.managerPersona.setUsuaId =
                              user['id'], // aqui estaba tu string
                          persIdentificacion: personaForm.managerPersona.setPersIdentificacion =
                              argPersona.cedula,
                          persNombres: personaForm.managerPersona.setPersNombres =
                              argPersona.nombres,
                          persApellidos: personaForm.managerPersona.setPersApellidos =
                              argPersona.apellidos,
                          persCelular: personaForm.managerPersona.setPersCelular =
                              argPersona.telefono,
                          persFechaNacimiento:
                              personaForm.managerPersona.setPersFechaNacimiento =
                                  argPersona.fechaNacimiento,
                          persSexo: personaForm.managerPersona.setPersSexo =
                              argPersona.genero,
                          provId: personaForm.managerPersona.setProvId =
                              retornoProvincia, // estaba String
                          ciudId: personaForm.managerPersona.setCiudId =
                              retornoCiudad); // estaba String);

                      // metodo agregar usuario
                      RespuestaModel persona =
                          await personaForm.registrarPersona();
                      Map<String, dynamic> pers = jsonDecode(persona.data);
                      print('.......');
                      print(pers['id']);
                      idPersona = pers['id'];
                      print('......');
                      // duracion del efecto, animacion
                      /*   await Future.delayed(Duration(seconds: 2)); */
                      await Future.delayed(Duration(milliseconds: 1000));
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'familiar', (Route<dynamic> route) => false,
                          arguments: IdPersonaArguments(persId: pers['id']));
                      /*  Navigator.pushReplacementNamed(
                        context,
                        'familiar',
                        arguments: IdPersonaArguments(persId: pers['id']),
                      ); */
                    },
            )
          ],
        ),
      ),
    );
  }
}

final idPers = idPersona;
