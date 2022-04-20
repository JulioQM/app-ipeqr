import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/exportArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';

class VerificacionPages extends StatelessWidget {
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
                        'Especificar código',
                        style: Theme.of(context).textTheme.headline4,
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
                Column(
                  children: <Widget>[
                    Title(
                      color: Colors.black,
                      child: Text(
                        'Inicio',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.home),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'bienvenida', (route) => false);
                      },
                    )
                  ],
                )
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
    // llamo parametro de login
    UsuarioIdEmailArgument argUsuario =
        ModalRoute.of(context).settings.arguments;
    return Container(
      child: Form(
        key: loginForm.formKey,
        // activar validacion en modo de interación con la pantalla
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                  'Le hemos enviado el código de verificación a su correo electrónico. Escriba el código para iniciar sesión.'),
            ),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              style: TextStyle(), //agrega @ en teclado
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Código',
                  hintText: 'Ingrese código de verificación',
                  prefixIcon: Icons.copy_rounded),
              onChanged: (value) =>
                  loginForm.managerUsuario.setUsuaCodigo = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'El código es obligatoria';
              },
            ),
            SizedBox(height: 30),
            // boton con acción de ingresar
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  loginForm.isLoading ? 'Espere' : 'Comprobar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus(); // bloquea mi boton
                      if (!loginForm.isValidForm()) return;
                      loginForm.managerUsuario.setUsuaId = argUsuario.idUsuario;
                      RespuestaModel respuesta =
                          await loginForm.verificarCodigo();

                      if (respuesta.success ?? true) {
                        // si es correcto me navegara a la pantalla principal
                        loginForm.isLoading = true;
                        await Future.delayed(Duration(seconds: 2));
                        Navigator.pushReplacementNamed(
                          context,
                          'miperfilAutenticacion',
                          arguments: UsuarioIdArguments(
                            idUsuario: argUsuario.idUsuario,
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
