import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/exportArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class SendCodigoEmailPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBackground(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: 140),
                CardContainer(
                  // llamo mi widget contenedor
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        'Restablecer su contraseña',
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      ChangeNotifierProvider(
                        // crea una instancia changeNotifierProvider
                        create: (_) => LoginProvider(),
                        child: _FormularioLogin(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 80),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FormularioLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // con esta variable puedo ingresar a la instancia de la clase LoginFormProvider
    final loginForm = Provider.of<LoginProvider>(context, listen: true);
    return Container(
      child: Form(
        key: loginForm.formKey,
        // activar validacion en modo de interación con la pantalla
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                'Para recibir un codigo de verificación para restablecer su contraseña, ingrese su dirección de correo electrónico que este enlazado a su cuenta.',
                textAlign: TextAlign.justify,
              ),
            ),
            Divider(
              color: Colors.transparent,
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(), //agrega @ en teclado
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Correo electrónico',
                  hintText: 'Ingrese su correo electrónico',
                  prefixIcon: Icons.email_outlined),
              onChanged: (value) =>
                  loginForm.managerUsuario.setUsuaEmail = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'El correo electrónico es obligatoria';
              },
            ),
            SizedBox(height: 30),
            /*  Text('Si recibiste el correo?'), */
            // boton con acción de ingresar
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere' : 'Restablecer contraseña',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus(); // bloquea mi boton
                      if (!loginForm.isValidForm()) return;

                      RespuestaModel respuesta =
                          await loginForm.enviarCodigoEmail();

                      if (respuesta.success ?? true) {
                        // si es correcto me navegara a la pantalla principal
                        loginForm.isLoading = true;

                        Map<String, dynamic> userId =
                            jsonDecode(respuesta.data);
                        print(userId);
                        print(userId["usua_id"]);
                        await Future.delayed(Duration(seconds: 4));
                        Navigator.pushReplacementNamed(
                          context,
                          'comprobarCodeEmail',
                          arguments: UsuarioIdArguments(
                            idUsuario: userId["usua_id"],
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            respuesta.mensaje,
                            textAlign: TextAlign.center,
                          ),
                        ));
                        loginForm.isLoading = false;
                      }
                    },
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
