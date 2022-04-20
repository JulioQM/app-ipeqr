import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/pages/exportPages.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() => runApp(AppStage());

class AppStage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // para mucho provedores de informacion
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: true,
          create: (_) => ProvinciaProvider(),
        ),
        ChangeNotifierProvider(
          lazy: /*  true */ false,
          create: (_) => CiudadProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginProvider(),
          /*  lazy: true, */
        ),
        ChangeNotifierProvider(
          create: (_) => RolProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => UsuarioProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => FamiliaProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => PersonaProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => ExpedienteProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          lazy: true,
          create: (_) => SubirImagenProvider(),
        ),
      ],
      child: MyApp(),
    );
  }
}

// USO DE STATELESWIDGET YA QUE SON ELEMENTOS DINAMICOS
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    /*<activity android:name=".miActivity"
...    android:screenOrientation="portrait" />*/
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'), // English, no country code
        Locale('es', 'ES'), // Spanish, no country code
      ],
      title: 'Bienvenidos al LookHere',
      // en este apartado inicializo cual va hacer la pantalla principal
      initialRoute: 'bienvenida',
      // en esta apartado se encuentras rutas de las paginas existentes, la cual permitira direccionarnos a las diferentes paginas
      routes: {
        'bienvenida': (_) => BienvenidaPages(),
        'login': (_) => LoginPages(),
        'loginAdmin': (_) => LoginAdminPages(),
        'verificacion': (_) => VerificacionPages(),
        'enviarCodeEmail': (_) => SendCodigoEmailPages(),
        'comprobarCodeEmail': (_) => ComprobarCodigoEmailPages(), //cambia clave
        'usuario': (_) => RegisterUsuarioPages(),
        'identidad': (_) => RegisterIdentidadPages(),
        'residencia': (_) => RegisterResidenciaPages(),
        'familiar': (_) => RegisterFamiliarPages(),
        'expediente': (_) => RegisterExpedientePages(),
        'miperfilRegistro': (_) => PerfilRegistro(), // ruta de prueba
        'miperfilAutenticacion': (_) => PerfilAutenticacion(),
        'administracion': (_) => AdminPages(),
        'perfilAdministracion': (_) => PerfilAdmin(),
        'loading': (_) => LoadingPages(),
        'agregarFamiliar': (_) => AgregarFamiliarPages(),
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[200], // antes 300 2022-04-07
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.indigo),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.indigo, elevation: 0)),
    );
  }
}
