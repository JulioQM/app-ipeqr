import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/exportArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class LoginAdminPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: LoginBackground(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: /* 140 */ responsive.altop(35)),
                CardContainer(
                  // llamo mi widget contenedor
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: /* 10 */ responsive.altop(5)),
                      Text(
                        'Login Admin',
                        style: /*  Theme.of(context).textTheme.headline4 */ TextStyle(
                            fontSize: responsive.diagonalp(3.5),
                            color: Colors.black38),
                      ),
                      SizedBox(height: /* 30 */ responsive.altop(5)),
                      ChangeNotifierProvider(
                        // crea una instancia changeNotifierProvider
                        create: (_) => LoginProvider(),
                        child: _FormularioLogin(),
                      )
                    ],
                  ),
                ),
                SizedBox(height: /* 10 */ responsive.altop(2.5)),
                /*  SizedBox(height:/*  80 */responsive.altop(10)),*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FormularioLogin extends StatefulWidget {
  @override
  __FormularioLoginState createState() => __FormularioLoginState();
}

class __FormularioLoginState extends State<_FormularioLogin> {
  bool claveVisible;
  @override
  void initState() {
    super.initState();
    claveVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    // con esta variable puedo ingresar a la instancia de la clase LoginFormProvider
    final loginForm = Provider.of<LoginProvider>(context, listen: true);
    final Responsive responsives = Responsive.of(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        // activar validacion en modo de interación con la pantalla
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(), //agrega @ en teclado
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Usuario o Email',
                  hintText: 'Ingrese el usuario o email',
                  prefixIcon: Icons.person_outline),
              onChanged: (value) =>
                  loginForm.managerUsuario.setUsuaAlias = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'El usuario es obligatoria';
              },
            ),
            // bloque de repeticion de contraseña
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: !this.claveVisible,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.inputDecoration(
                labelText: 'Password',
                hintText: '**********',
                prefixIcon: Icons.lock_outline,
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    this.claveVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.deepPurple,
                  ),
                  onPressed: () {
                    setState(() {
                      this.claveVisible = !this.claveVisible;
                    });
                  },
                ),
              ),
              // agrego el valor de las cajas de texto en las propiedades del provider
              onChanged: (value) =>
                  loginForm.managerUsuario.setUsuaClave = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'La contraseña es obligatoria';
              },
            ),
            SizedBox(height: /* 30 */ responsives.altop(10)),
            // boton con acción de ingresar
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
                loginForm.isLoading ? 'Espere' : 'Ingresar',
                style: TextStyle(
                    color: Colors.white, fontSize: responsives.diagonalp(1.6)),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus(); // bloquea mi boton
                      if (!loginForm.isValidForm()) return;
                      RespuestaModel respuesta =
                          await loginForm.autenticacionAdmin();

                      if (respuesta.success ?? true) {
                        // si es correcto me navegara a la pantalla principal
                        loginForm.isLoading = true;
                        Map<String, dynamic> userId =
                            jsonDecode(respuesta.data);
                        /* print(userId);
                        print(respuesta.data);
                        print(respuesta.mensaje); */

                        /* await Future.delayed(Duration(seconds: 2)); */

                        /* Navigator.pushReplacementNamed(
                          context,
                          'administracion',
                          arguments: UsuarioIdArguments(
                            idUsuario: userId['usua_id'],
                          ),
                        ); */
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'administracion',
                          (route) => false,
                          arguments: UsuarioIdArguments(
                            idUsuario: userId['usua_id'],
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(respuesta.mensaje),
                        ));
                        loginForm.isLoading = false;
                      }
                    },
            ),
            SizedBox(height: /* 50 */ responsives.altop(5)),
          ],
        ),
      ),
    );
  }
}
