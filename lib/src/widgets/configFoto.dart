import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class CardFoto extends StatefulWidget {
  final String rutaFoto;
  final int id;
  CardFoto({Key key, this.rutaFoto, this.id}) : super(key: key);
  @override
  State<CardFoto> createState() => _CardFotoState();
}

class _CardFotoState extends State<CardFoto> {
  XFile pickers;
  File newPictureFile;
  String url;

  @override
  void initState() {
    url = widget.rutaFoto;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () => showOptionsDialog(context),
          child: Container(
            child: FotoContainer(url: this.url),
          ),
        ),
      ],
    );
  }

  // metodo para subir imagen por medio de la camara
  void camara() async {
    final subir = Provider.of<SubirImagenProvider>(context, listen: false);
    final picker = new ImagePicker();
    final XFile pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (pickedFile == null) {
      print('No seleccionó nada');
      return;
    }
    print("tenemos imagen ..............." + pickedFile.path);
    url = pickedFile.path;

    newPictureFile = File.fromUri(Uri(path: url));

    Navigator.pop(context);
    await subir.subirImagen(this.newPictureFile, widget.id);
    setState(() {});
  }

  // metodo para subir imagen por medio de la galeria
  void galeria() async {
    final subir = Provider.of<SubirImagenProvider>(context, listen: false);
    final picker = new ImagePicker();
    final XFile pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (pickedFile == null) {
      print('No seleccionó nada');
      return;
    }
    print("tenemos imagen ..............." + pickedFile.path);
    url = pickedFile.path;
    newPictureFile = File.fromUri(Uri(path: url));
    // nota si primero agrego el setState se cambia la fotografia de manera rapida
    // nota si agrego despues el setState se cambia luego de segundos
    Navigator.pop(context);
    /* setState(() {}); */ //// esto primero permite que cargue la foto y luego mostrar
    await subir.subirImagen(this.newPictureFile, widget.id);
    setState(() {});
  }

// agregamos funcionalidad de cuadro de dialogo para subir fotografia, ya sea para una seleccion de camara o galeria
  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Seleccione la opcion",
            /* style: TextStyle(color: Colors.blue), */
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Divider(
                  height: 1,
                  color: Colors.blue,
                ),
                ListTile(
                  onTap: () {
                    galeria();
                  },
                  title: Text("Galeria"),
                  leading: Icon(
                    Icons.account_box,
                    color: Colors.blue,
                  ),
                ),
                Divider(
                  height: 1,
                  color: Colors.blue,
                ),
                ListTile(
                  onTap: () {
                    camara();
                  },
                  title: Text("Cámara"),
                  leading: Icon(
                    Icons.camera,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
