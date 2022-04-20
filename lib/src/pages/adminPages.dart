import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/exportArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class AdminPages extends StatefulWidget {
  AdminPages({Key key}) : super(key: key);

  @override
  State<AdminPages> createState() => _AdminPagesState();
}

int idusuario = 0;

class _AdminPagesState extends State<AdminPages> {
  var tableRow = new TableRow();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var usuario =
        Provider.of<UsuarioProvider>(context, listen: false /* ,true */);
    var rol = Provider.of<RolProvider>(context, listen: false);
    var persForm = Provider.of<PersonaProvider>(context, listen: false);
    UsuarioIdArguments argUsuario = ModalRoute.of(context).settings.arguments;
    if (argUsuario.idUsuario == null) {
      Navigator.pop(context);
    }

    idusuario = argUsuario.idUsuario;

    return WillPopScope(
      onWillPop: () async {
        return await _onBackPressed();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Perfil de Administración',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          height: double.infinity,
          child: Column(
            children: [
              // datos de fotografia
              FutureBuilder<List<Persona>>(
                initialData: [],
                future: persForm
                    .getMostrarDatosAutenticacionPersona(argUsuario.idUsuario),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Persona>> snapshot) {
                  List<Persona> pers = snapshot.data ?? [];
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      for (Persona persona in pers)
                        Center(
                          child: CardFoto(
                            rutaFoto: persona.getPersFoto,
                            id: argUsuario.idUsuario,
                          ),
                        ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      for (Persona persona in pers)
                        // en este apartado abstrayo 1 nombre y 1 apellido
                        Text(
                          (persona.getPersNombres.toString().split(' ').first)
                                  .toUpperCase()
                                  .characters
                                  .first +
                              (persona.getPersNombres
                                      .toString()
                                      .split(' ')
                                      .first)
                                  .substring(
                                      1,
                                      (persona.getPersNombres
                                              .toString()
                                              .split(' ')
                                              .first)
                                          .length)
                                  .toLowerCase() +
                              ' ' +
                              (persona.getPersApellidos
                                      .toString()
                                      .split('')
                                      .first +
                                  (persona.persApellidos
                                          .toString()
                                          .split(' ')
                                          .first)
                                      .substring(1)
                                      .toLowerCase()),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                    ],
                  );
                },
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.1, -0.1),
                          blurRadius: 15,
                        )
                      ],
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                  /* color: Colors.pink, */
                  child: ListView(
                    children: <Widget>[
                      FutureBuilder<List<Persona>>(
                        initialData: [],
                        future: persForm.getMostrarDatosAutenticacionPersona(
                            argUsuario.idUsuario),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Persona>> snapshot) {
                          List<Persona> pers = snapshot.data ?? [];
                          if (!snapshot.hasData)
                            return CircularProgressIndicator();
                          return Column(
                            children: <Widget>[
                              for (Persona persona in pers)
                                ExpansionTile(
                                  leading: Icon(Icons.people_alt_outlined),
                                  title: Text('Datos Personales'),
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(persona.persNombres),
                                      subtitle: Text(
                                        'Nombres',
                                        style: TextStyle(color: Colors.indigo),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(persona.persApellidos),
                                      subtitle: Text(
                                        'Apellidos',
                                        style: TextStyle(color: Colors.indigo),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(persona.persIdentificacion),
                                      subtitle: Text(
                                        'Cédula',
                                        style: TextStyle(color: Colors.indigo),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(persona.persCelular),
                                      subtitle: Text(
                                        'Número telefónico',
                                        style: TextStyle(color: Colors.indigo),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(persona.persDiaNacimiento),
                                      subtitle: Text(
                                        'Fecha de Nacimiento',
                                        style: TextStyle(color: Colors.indigo),
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        (persona.persSexo.contains('M')
                                            ? 'Masculino'
                                            : 'Femenino'),
                                      ),
                                      subtitle: Text(
                                        'Género',
                                        style: TextStyle(color: Colors.indigo),
                                      ),
                                    )
                                  ],
                                ),
                              // desde aqui comienza la administracion
                              ExpansionTile(
                                leading: Icon(Icons.supervised_user_circle),
                                title: Text('Usuarios registrados'),
                                children: <Widget>[
                                  Divider(),
                                  FutureBuilder<List<Usuario>>(
                                    initialData: [],
                                    future: usuario.getListaUsuario(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<Usuario>> snapshot) {
                                      List<Usuario> users = snapshot.data ?? [];
                                      if (!snapshot.hasData)
                                        return CircularProgressIndicator();
                                      return Column(
                                        children: <Widget>[
                                          for (var item in users)
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.grey[50],
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                    color: Colors.black38,
                                                    offset: Offset(0.1, -0.1),
                                                    blurRadius: 5,
                                                  )
                                                ],
                                              ),
                                              child: ExpansionTile(
                                                leading: Text(
                                                    item.getUsuaId.toString()),
                                                title: Text(item.getUsuaAlias),
                                                subtitle: Text(
                                                  'Usuario',
                                                  style: TextStyle(
                                                      color: Colors.indigo),
                                                ),
                                                children: <Widget>[
                                                  ListTile(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    leading: Material(
                                                      elevation: 10,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      color: Colors.white,
                                                      child: IconButton(
                                                        splashColor:
                                                            Colors.black26,
                                                        splashRadius: 24,
                                                        icon: Icon(
                                                          Icons.remove_red_eye,
                                                          color: Colors.indigo,
                                                        ),
                                                        tooltip: 'Ver perfil',
                                                        onPressed: () {
                                                          /* Navigator
                                                              .pushReplacementNamed(
                                                            context,
                                                            'perfilAdministracion',
                                                            arguments:
                                                                UsuarioIdArguments(
                                                              idUsuario: item
                                                                  .getUsuaId,
                                                            ),
                                                          ); */
                                                          Navigator
                                                              .pushNamedAndRemoveUntil(
                                                            context,
                                                            'perfilAdministracion',
                                                            (route) => true,
                                                            arguments:
                                                                UsuarioIdArguments(
                                                              idUsuario: item
                                                                  .getUsuaId,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    title:
                                                        Text(item.getUsuaEmail),
                                                    subtitle: Text(
                                                      'Correo Electrónico',
                                                      style: TextStyle(
                                                          color: Colors.indigo),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                              ExpansionTile(
                                leading: Icon(Icons.people),
                                title: Text('Roles registrados'),
                                children: <Widget>[
                                  Divider(),
                                  FutureBuilder<List<Rol>>(
                                    initialData: [],
                                    future: rol.getListaRol(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<Rol>> snapshot) {
                                      List<Rol> roles = snapshot.data ?? [];
                                      if (!snapshot.hasData)
                                        return CircularProgressIndicator();
                                      return Column(
                                        children: <Widget>[
                                          for (var item in roles)
                                            Container(
                                              margin: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.grey[50],
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                    color: Colors.black38,
                                                    offset: Offset(0.1, -0.1),
                                                    blurRadius: 5,
                                                  )
                                                ],
                                              ),
                                              child: ListTile(
                                                leading: Text(
                                                    item.getRolId.toString()),
                                                title: Text(item.getRolNombre),
                                                subtitle: Text(
                                                  'Rol',
                                                  style: TextStyle(
                                                      color: Colors.indigo),
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 50),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.deepPurple),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: MaterialButton(
                                  minWidth: size.width * 0.7,
                                  elevation: 0,
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        "bienvenida", (route) => false);
                                  },
                                  child: Text(
                                    'Inicio',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ) //aqui va cierre de future
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // REGRESAR
  Future<bool> _onBackPressed() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[50],
        /* Color.fromRGBO(0, 68, 69, .5)  */
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        title: Text(
          "Confirmar",
          textAlign: TextAlign.center,
        ),
        content: Text("¿Deseas salir de la aplicación?"),
        actions: <Widget>[
          TextButton(
            child: Text('Regresar a Inicio',
                style: TextStyle(decoration: TextDecoration.underline)),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, 'bienvenida', (route) => false);
            },
          ),
          TextButton(
            child: Text(
              'No',
              style: TextStyle(color: Colors.deepPurple),
            ),
            onPressed: () => Navigator.pop(context, false),
          ),
          TextButton(
            child: Text(
              'Si',
              style: TextStyle(color: Colors.deepPurple),
            ),
            onPressed: () => SystemNavigator.pop(),
          ),
        ],
      ),
    );
  }
}

final idperfil = idusuario;
