import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/exportArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';

class ComprobarCodigoEmailPages extends StatelessWidget {
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
                SizedBox(height: 50),
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

class _FormularioLogin extends StatefulWidget {
  @override
  __FormularioLoginState createState() => __FormularioLoginState();
}

class __FormularioLoginState extends State<_FormularioLogin> {
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
    // con esta variable puedo ingresar a la instancia de la clase LoginFormProvider
    final loginForm = Provider.of<LoginProvider>(context, listen: true);
    // llamo parametro de login
    UsuarioIdArguments argUsuario = ModalRoute.of(context).settings.arguments;
    return Container(
      child: Form(
        key: loginForm.formKey,
        // activar validacion en modo de interación con la pantalla
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                  'Primero escriba el código de verificación que fue enviada a su correo electrónico, seguido su nueva contraseña.'),
            ),
            SizedBox(
              height: 20,
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
                  loginForm.managerUsuario.setUsuaCodigoCambiarClave = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'El código es obligatoria';
              },
            ),
            SizedBox(height: 20),
            // caja de texto para el atributo contraseña o clave
            TextFormField(
              obscureText: !this.claveVisible,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.inputDecoration(
                labelText: 'Nueva contraseña',
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
                  loginForm.managerUsuario.setUsuaClave = value,
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
                labelText: 'Confirmar nueva contraseña',
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
                var verificador = loginForm.managerUsuario.getUsuaClave;
                return (value != null && value.isNotEmpty)
                    ? validaciones.validarClave(
                        clave: verificador, claveRepetida: value)
                    : 'La contraseña es obligatoria';
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
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                child: Text(
                  loginForm.isLoading
                      ? 'Reseteando clave'
                      : 'Restablecer contraseña',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus(); // bloquea mi boton
                      if (!loginForm.isValidForm()) return;
                      loginForm.managerUsuario.setUsuaId = argUsuario.idUsuario;
                      RespuestaModel respuesta = await loginForm.cambiarClave();
                      if (respuesta.success ?? true) {
                        // si es correcto me navegara a la pantalla principal
                        loginForm.isLoading = true;
                        await Future.delayed(Duration(seconds: 3));
                        Navigator.pushReplacementNamed(context, 'login');
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
