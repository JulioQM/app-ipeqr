import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/exportArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class RegisterIdentidadPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: LoginBackground(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: /*  120 */ responsive.altop(30)),
                CardContainer(
                  // llamo mi widget contenedor
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: /* 10 */ responsive.altop(0.5)),
                      Text(
                        'Ingrese tus datos personales',
                        textAlign: TextAlign.center,
                        style: /* Theme.of(context).textTheme.headline6 */ TextStyle(
                            fontSize: responsive.diagonalp(2.8),
                            color: Colors.black45),
                      ),
                      SizedBox(height: /* 10 */ responsive.altop(3)),
                      ChangeNotifierProvider(
                        // crea una instancia changeNotifierProvider
                        create: (_) => PersonaProvider(),
                        child: _FormularioRegister(),
                      ),
                      SizedBox(height: /* 10 */ responsive.altop(2.5)),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _FormularioRegister extends StatefulWidget {
  @override
  __FormularioRegisterState createState() => __FormularioRegisterState();
}

String opcionSelecionado;

class __FormularioRegisterState extends State<_FormularioRegister> {
   @override
  void initState() {
    super.initState();
    opcionSelecionado = null;
  }

  @override
  Widget build(BuildContext context) {
    // con esta variable puedo ingresar a la instancia de la clase PersonaProvider
    final personaForm = Provider.of<PersonaProvider>(context, listen: true);
    final Responsive responsives = Responsive.of(context);
    return Container(
      child: Form(
        key: personaForm.formKey,
        // activar validacion en modo de interacion
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            // caja de texto para el atributo nombre
            TextFormField(
              autocorrect: true,
              keyboardType: TextInputType.name,
              inputFormatters: [UpperCaseTextFormatter()],
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Nombres',
                  hintText: 'Ingrese su nombre',
                  prefixIcon: Icons.account_box_rounded),
              // agrego el valor de las cajas de texto a las propiedades del provider personas
              onChanged: (value) =>
                  personaForm.managerPersona.setPersNombres = value.trim(),
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'El nombre  es obligatoria';
              },
            ),
            SizedBox(height: 20),
            // caja de texto para el atributo apellido
            TextFormField(
              autocorrect: true,
              keyboardType: TextInputType.name,
              inputFormatters: [UpperCaseTextFormatter()],
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Apellidos',
                  hintText: 'Ingrese su apellido',
                  prefixIcon: Icons.account_box_rounded),
              // agrego el valor de las cajas de texto a las propiedades del provider personas
              onChanged: (value) =>
                  personaForm.managerPersona.setPersApellidos = value.trim(),
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'El apellido es obligatoria';
              },
            ),
            SizedBox(height: 20),
            // caja de texto para el atributo cedula
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Cédula',
                  hintText: 'Ingrese su cédula',
                  prefixIcon: Icons.account_box_rounded),
              // agrego el valor de las cajas de texto a las propiedades del provider personas
              onChanged: (value) =>
                  personaForm.managerPersona.setPersIdentificacion = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? validaciones.validarNumeroCedula(cedula: value)
                    : 'La cédula es obligatoria';
              },
            ),
            /* SizedBox(height: 20), */
            // caja de texto para el atributo celular
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.phone,
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Teléfono celular',
                  hintText: 'Ingrese su numero celular',
                  prefixIcon: Icons.add_call),
              // agrego el valor de las cajas de texto a las propiedades del provider personas
              onChanged: (value) =>
                  personaForm.managerPersona.setPersCelular = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? validaciones.validarNumero(numero: value)
                    : 'El número de teléfono es obligatoria';
              },
            ),
            // caja de texto para el atributo fecha nacimiento
            DataCalendars(),
            // caja de texto para el atributo sexo
            SizedBox(height: 30),
            DropdownButtonFormField<String>(
              decoration: InputDecorations.inputDecoration(
                  prefixIcon: Icons.accessibility),
              value: opcionSelecionado,
              hint: Text('Seleccione su Género'),
              items: ListaGenero.getOpcionesDropdown(),
              // agrego el valor de las cajas de texto a las propiedades del provider personas
              onChanged: (value) {
                setState(
                  () {
                    opcionSelecionado = value;
                    personaForm.managerPersona.setPersSexo = value;
                    print(opcionSelecionado);
                  },
                );
              },
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : "Seleccione el género";
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
                  color: Colors.white,
                  fontSize: responsives.diagonalp(1.6),
                ),
              ),
              onPressed: personaForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus(); // bloquea mi boton
                      if (!personaForm.isValidForm()) return; // validacíon
                      // uso de setter para asignar valor al atributo fecha nacimiento
                      personaForm.managerPersona.setPersFechaNacimiento =
                          inputFielDateController.value.text;
                      // metodo para recolectar los valores de la clase Persona
                      RespuestaModel respuesta =
                          await personaForm.obtenerEntidad();
                      print(respuesta.data);
                      if (respuesta.success ?? true) {
                        personaForm.isLoading = true;
                        // llamo a mis argumentos del formulario de Usuario
                        final UsuariosArguments argUsuario =
                            ModalRoute.of(context).settings.arguments;
                        Map<String, dynamic> user = jsonDecode(respuesta.data);
                        print(user['body']);
                        // duracion del efecto, animacion
                        /*   await Future.delayed(Duration(seconds: 2)); */
                        await Future.delayed(Duration(milliseconds: 1000));
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          'residencia',
                          (Route<dynamic> route) => false,
                          arguments: IdentidadArguments(
                            // pertenece a usuario
                            alias: argUsuario.nombre,
                            correo: argUsuario.correo,
                            clave: argUsuario.clave,
                            // pertenece identidad
                            cedula: user['body']['pers_identificacion'],
                            nombres: user['body']['pers_nombres'],
                            apellidos: user['body']['pers_apellidos'],
                            telefono: user['body']['pers_celular'],
                            genero: user['body']['pers_sexo'],
                            fechaNacimiento: user['body']
                                ['pers_fecha_nacimiento'],
                          ),
                        );
                        /* Navigator.pushReplacementNamed(
                          context,
                          'residencia',
                          arguments: IdentidadArguments(
                            // pertenece a usuario
                            alias: argUsuario.nombre,
                            correo: argUsuario.correo,
                            clave: argUsuario.clave,
                            // pertenece identidad
                            cedula: user['body']['pers_identificacion'],
                            nombres: user['body']['pers_nombres'],
                            apellidos: user['body']['pers_apellidos'],
                            telefono: user['body']['pers_celular'],
                            genero: user['body']['pers_sexo'],
                            fechaNacimiento: user['body']
                                ['pers_fecha_nacimiento'],
                          ),
                        ); */
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(respuesta.mensaje),
                          ),
                        );
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
