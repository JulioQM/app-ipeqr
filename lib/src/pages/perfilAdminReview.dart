import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/exportArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/pages/adminPages.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:provider/provider.dart';

class PerfilAdmin extends StatefulWidget {
  @override
  State<PerfilAdmin> createState() => _PerfilAdminState();
}

class _PerfilAdminState extends State<PerfilAdmin> {
  var famil;
  @override
  void initState() {
    super.initState();
    setState(() {});
    famil = Provider.of<FamiliaProvider>(context, listen: false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var persForm = Provider.of<PersonaProvider>(context, listen: false);
    /* var famil = Provider.of<FamiliaProvider>(context, listen: false); */
    UsuarioIdArguments argUsuario = ModalRoute.of(context).settings.arguments;
    if (argUsuario.idUsuario == null) {
      Navigator.pop(context);
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
            color: Colors.indigo,
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.indigo,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                'administracion',
                arguments: UsuarioIdArguments(
                  idUsuario: idperfil,
                  /* email: */
                ),
              );
            }),
        centerTitle: true,
        title: Text(
          'Perfil',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
                            (persona.getPersNombres.toString().split(' ').first)
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
                                initiallyExpanded: true,
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
                            for (Persona persona in pers)
                              ExpansionTile(
                                leading: Icon(Icons.place),
                                title: Text('Datos de Residencia'),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(persona.provNombre),
                                    subtitle: Text(
                                      'Provincia',
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(persona.ciudNombre),
                                    subtitle: Text(
                                      'Ciudad',
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(persona.persDireccion),
                                    subtitle: Text(
                                      'Dirección',
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                  ),
                                ],
                              ),
                            for (Persona persona in pers)
                              ExpansionTile(
                                leading: Icon(Icons.contacts_outlined),
                                title: Text('Historial Médico'),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(persona.enferNombre),
                                    subtitle: Text(
                                      'Enfermedad',
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(persona.enferDescMedicacion),
                                    subtitle: Text(
                                      'Descripción de Medicamento',
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(persona.enferDescDosificacion),
                                    subtitle: Text(
                                      'Descripción de Dosificación',
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(persona.enferDescEnfermedad),
                                    subtitle: Text(
                                      'Descripción de Enfermedad',
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                  )
                                ],
                              ),
                            for (Persona persona in pers)
                              ExpansionTile(
                                leading: Icon(Icons.family_restroom),
                                title: Text('Contacto familiar'),
                                children: <Widget>[
                                  Divider(),
                                  FutureBuilder<List<Familiar>>(
                                    initialData: [],
                                    future: famil.getListaFamiliarIdPersona(
                                        busqueda: persona.persId),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<Familiar>>
                                            snapshot) {
                                      List<Familiar> familiares =
                                          snapshot.data ?? [];
                                      if (!snapshot.hasData)
                                        return CircularProgressIndicator();

                                      return Column(
                                        children: <Widget>[
                                          IconButton(
                                              icon: Icon(
                                                Icons.add_call,
                                                color: Colors.indigo,
                                              ),
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                    context, "agregarFamiliar",
                                                    arguments:
                                                        IdPersonaPerfilAdminArguments(
                                                            id: persona
                                                                .getPersId));
                                              }),
                                          for (var item in familiares)
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
                                                leading: Icon(Icons
                                                    .supervised_user_circle),
                                                title: Text(
                                                    item.getFamilNombres +
                                                        " " +
                                                        item.familApellidos),
                                                subtitle: Text(
                                                  'Familiar',
                                                  style: TextStyle(
                                                      color: Colors.indigo),
                                                ),
                                                children: <Widget>[
                                                  ListTile(
                                                    title: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text('Dirección:',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .indigo)),
                                                        Text(item
                                                            .familDireccion),
                                                        Divider(),
                                                        Text('Teléfono:',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .indigo)),
                                                        Text(item.familCelular),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            /* for (Persona persona in pers)
                              ExpansionTile(
                                leading: Icon(Icons.family_restroom),
                                title: Text('Contacto familiar'),
                                children: <Widget>[
                                  ListTile(
                                    title: Text(persona.familNombresCompletos),
                                    subtitle: Text(
                                      'Nombre familiar',
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(persona.familDireccion),
                                    subtitle: Text(
                                      'Dirección',
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(persona.familCelular),
                                    subtitle: Text(
                                      'Contacto familiar',
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                  )
                                ],
                              ), */
                            for (Persona persona in pers)
                              ExpansionTile(
                                leading: Icon(Icons.qr_code),
                                title: Text('Código QR'),
                                children: <Widget>[
                                  /* CrearQR.addQR(id: persona.persId), */
                                  /* for (Persona persona in pers) */
                                  ButtonDescargar(
                                    id: persona.persId,
                                  )
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
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    "administracion",
                                    (route) => false,
                                    arguments: UsuarioIdArguments(
                                      idUsuario: idperfil,
                                    ),
                                  );
                                },
                                child: Text(
                                  'Regresar a administración',
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
    );
  }
}
