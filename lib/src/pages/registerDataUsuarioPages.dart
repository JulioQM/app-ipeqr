import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/usuariosArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class RegisterUsuarioPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: LoginBackground(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: /* 120 */ responsive.altop(35)),
                CardContainer(
                  // llamo mi widget contenedor
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: /* 10 */ responsive.altop(5)),
                      Text(
                        'Crear Cuenta',
                        style: /* Theme.of(context).textTheme.headline4 */ TextStyle(
                            fontSize: responsive.diagonalp(3.5),
                            color: Colors.black38),
                      ),
                      SizedBox(height: /*  20 */ responsive.altop(5)),
                      ChangeNotifierProvider(
                        // crea una instancia changeNotifierProvider
                        create: (_) => UsuarioProvider(),
                        child: _FormularioRegister(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: /* 10 */ responsive.altop(10)),
                TextButtons.etiquetaTextButton(
                  titulo: '¿Ya tienes una cuenta?',
                  direccionamientoPagina: 'login',
                  context: context,
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

class _FormularioRegister extends StatefulWidget {
  @override
  __FormularioRegisterState createState() => __FormularioRegisterState();
}

class __FormularioRegisterState extends State<_FormularioRegister> {
  bool claveVisible;
  bool claveVisibleVerify;
  @override
  void initState() {
    super.initState();
    claveVisible = false;
    claveVisibleVerify = false;
  }

  @override
  Widget build(BuildContext context) {
    // con esta variable puedo ingresar a la instancia de la clase UsuarioProvider
    final usuarioForm = Provider.of<UsuarioProvider>(context, listen: true);
    final Responsive responsives = Responsive.of(context);
    return Container(
      child: Form(
        key: usuarioForm.formKey,
        // activar validacion en modo de interacion
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            // caja de texto para el atributo email
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecorations.inputDecoration(
                    labelText: 'Correo Electrónico',
                    hintText: 'example@hotmail.com',
                    prefixIcon: Icons.attach_email_outlined),
                // agrego el valor de las cajas de texto a las propiedades del provider Usuario
                onChanged: (value) =>
                    usuarioForm.managerUsuario.setUsuaEmail = value.trim(),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return validaciones.validarEmail(value);
                  }
                  return 'El correo es obligatorio';
                }),

            SizedBox(height: 20),
            // caja de texto para el atributo nombre usuario
            TextFormField(
              autocorrect: true,
              keyboardType: TextInputType.name,
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Nombre de usuario',
                  hintText: 'Ingrese su nombre de usuario',
                  prefixIcon: Icons.account_box_rounded),
              onChanged: (value) {
                usuarioForm.managerUsuario.setUsuaAlias = value.trim();
                print(usuarioForm.managerUsuario.getUsuaAlias.length);
              },
              validator: (value) {
                /* return (value != null && value.isNotEmpty)
                    ? null
                    : 'El nombre de usuario es obligatoria'; */
                if (value == null || value.trim().isEmpty) {
                  return 'El nombre de usuario es obligatoria';
                }
                if (value.trim().length < 4) {
                  return 'El nombre debe tener al menos 4 caracteres';
                }
                // Return null if the entered username is valid
                return null;
              },
            ),

            SizedBox(height: 20),
            // caja de texto para el atributo contraseña o clave
            TextFormField(
              obscureText: !this.claveVisible,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.inputDecoration(
                labelText: 'Contraseña',
                hintText: '**********',
                prefixIcon: Icons.lock_outline,
                suffixIcon: IconButton(
                  icon: Icon(
                      // Based on passwordVisible state choose the icon
                      this.claveVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.deepPurple),
                  onPressed: () {
                    setState(() {
                      this.claveVisible = !this.claveVisible;
                    });
                  },
                ),
              ),
              // agrego el valor de las cajas de texto a las propiedades del provider Usuario
              onChanged: (value) =>
                  usuarioForm.managerUsuario.setUsuaClave = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'La contraseña es obligatoria';
              },
            ),
            SizedBox(height: 20),
            // Caja de texto que va ha permitir la validación de la clave(simulación)
            TextFormField(
              obscureText: !this.claveVisibleVerify,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.inputDecoration(
                labelText: 'Repita la contraseña',
                hintText: '**********',
                prefixIcon: Icons.lock_outline,
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    this.claveVisibleVerify
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {
                    setState(() {
                      this.claveVisibleVerify = !this.claveVisibleVerify;
                    });
                  },
                ),
              ),
              onChanged: (value) => value,
              validator: (value) {
                var verificador = usuarioForm.managerUsuario.getUsuaClave;
                /*  return (value != null && value.isNotEmpty)
                    ? validaciones.validarClave(
                        clave: verificador, claveRepetida: value)
                    : 'La contraseña es obligatoria'; */
                if (value.isEmpty) {
                  return "La contraseña es obligatoria";
                } else if (!value.contains(verificador)) {
                  return "La contraseña no coincide";
                } else {
                  return validaciones.validarClave(
                      clave: verificador, claveRepetida: value);
                }
              },
            ),
            SizedBox(height: 30),
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
                usuarioForm.isLoading ? 'Espere' : 'Siguiente',
                style: TextStyle(
                    color: Colors.white, fontSize: responsives.diagonalp(1.6)),
              ),
              onPressed: usuarioForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus(); // bloquea mi boton
                      if (!usuarioForm.isValidForm()) return; // validacíon
                      RespuestaModel respuesta =
                          await usuarioForm.validarUsuario();
                      if (respuesta.success ?? true) {
                        // la sentencia de abajo sirve para decodificar el json de la data
                        Map<String, dynamic> user = jsonDecode(respuesta.data);
                        print(user['body']);
                        usuarioForm.isLoading = true;
                        // duracion del efecto, animacion
                        await Future.delayed(Duration(milliseconds: 1000));
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          'identidad',
                          (Route<dynamic> route) => false,
                          arguments: UsuariosArguments(
                            nombre: user['body']['usua_alias'],
                            correo: user['body']['usua_email'],
                            /*  clave: user['body']['usua_alias'], */
                            clave: user['body']['usua_clave'],
                          ),
                        );

                        /* Navigator.pushReplacementNamed(
                          context,
                          'identidad',
                          arguments: UsuariosArguments(
                            nombre: user['body']['usua_alias'],
                            correo: user['body']['usua_email'],
                            /*  clave: user['body']['usua_alias'], */
                            clave: user['body']['usua_clave'],
                          ),
                        ); */
                      } else {
                        // https://programmerclick.com/article/7085843645/
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              respuesta.mensaje,
                              textAlign: TextAlign.center,
                            ),
                            /*  backgroundColor: Colors.indigo, */
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
