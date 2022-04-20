import 'package:flutter/material.dart';
import 'package:augmented_reality_plugin_wikitude/architect_widget.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/ar/exportAR.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'sample.dart';

class ArViewState extends State<ArViewWidget> with WidgetsBindingObserver {
  ArchitectWidget architectWidget;
  String wikitudeTrialLicenseKey =
      "GvkkJKekZacESYETQWir7QWM/fIKGLhTJ4/fsbBCwd6NUr9bCccLOAlV4cJZV+/5L3NbB5jtZExM3RHfyQ6lFKOZJAjaxNYApKb8WQNVjyu4m8MM/JCuwFE0iYb7cW7lED+Sjv+LlPOefB91ht50+YQbdrXoeoEDFvoTP4QdQFpTYWx0ZWRfX5sggRbTWl62xizUburTEJ8SIBSZFpFvqz2iWKgEFZWJv/I1eGh7d3DgJmo3d+Z3CMK5irMYdCpy8PK8bCfPVd7AZKvCjVV10joD3f/IJ/wdawCgWfH8MlUL3h9MctZ9qtxzqkmlyhykm1BBkOdonyctdIrsX5iP7GwdqV7lGuL3Ptyu+dAF192xkxeqywruILnN9xJgct1d63eG0qsJDw+GH2uK+jmGs1kuC2MJkznuF/g7FsCpthYP0DIsPZ109XKYjz2zuNFHLLNCKNnEuCpbrKnHqQA4ReSu1sihBfr2SyrOGm4AxPPrCAvwSE06Tet39zrhaip21BWGmR4xejYBUz/EARniQhqvxnfOPJYdV4zpcwtv07cHoEGXdbl6fwuQLf5/Af827pO5XjqHxYXfVsKe189285MsY0ConUhZfT+3UjiWaHNOOl+voXZY5LLckR26q2L66boalYLMS8/+fnwrHN6E4D74r4mL8+pmq5aB+N7tj+Vrjsryv+m1+H8RQmEbbkWy9cqzDBOYTqE1UVCPo2rvyC3Z1vTvoWIku3HCoBp4QiVZo2MHBTy0NZaowqlTQVwI92/qADJ0TBG2sKpr3AmEGZh4Op8nj+F7aU1TFLm0c2ElUJYgPJdx/mgf0otSNVo+";

  Sample sample;
  String id;
  String loadPath = "";
  bool loadFailed = false;
  // ignore: non_constant_identifier_names
  ArViewState({this.sample}) {
    if (this.sample.path.contains("http://") ||
        this.sample.path.contains("https://")) {
      loadPath = this.sample.path;
    } else {
      loadPath = "samples/" + this.sample.path;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    architectWidget = new ArchitectWidget(
      onArchitectWidgetCreated: onArchitectWidgetCreated,
      licenseKey: wikitudeTrialLicenseKey,
      startupConfiguration: sample.startupConfiguration,
      features: sample.requiredFeatures,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        if (this.architectWidget != null) {
          this.architectWidget.pause();
        }
        break;
      case AppLifecycleState.resumed:
        if (this.architectWidget != null) {
          this.architectWidget.resume();
        }
        break;

      default:
    }
  }

  @override
  void dispose() {
    if (this.architectWidget != null) {
      this.architectWidget.pause();
      this.architectWidget.destroy();
    }
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  Future<void> onArchitectWidgetCreated() async {
    this.architectWidget.load(loadPath, onLoadSuccess, onLoadFailed);
    this.architectWidget.resume();
    // consumiendo api rest
    final persForm = Provider.of<PersonaProvider>(context, listen: false);
    var id = widget.id;
    var res = await persForm.getMostrarDatosRegistroPersona(id);
    // llamo a los datos de la api rest
    var idpers = (res[0].getPersId).toString();
    var nombre = res[0].getPersNombres;
    var apellido = res[0].getPersApellidos;
    var cedula = res[0].getPersIdentificacion;
    var genero = (res[0].getPersSexo).contains('M') ? 'Masculino' : 'Femenino';
    var localidad = res[0].getProvNombre + " - " + res[0].getCiudNombre;
    var direccion = res[0].getPersDireccion;
    var telefonoFamiliar = res[0].getFamilCelular;
    var nombreFamiliar = res[0].getFamilNombresCompletos;
    var enfermedad = res[0].getEnferNombre;
    var foto = res[0].getPersFoto;
    // llevo todos los elementos al ambiente de realidad aumentada
    this.architectWidget.callJavascript("World.handleValueFromQR(\"" +
        idpers +
        "\",\"" +
        nombre +
        "\",\"" +
        apellido +
        "\",\"" +
        cedula +
        "\",\"" +
        genero +
        "\",\"" +
        localidad +
        "\",\"" +
        direccion +
        "\",\"" +
        telefonoFamiliar +
        "\",\"" +
        nombreFamiliar +
        "\",\"" +
        enfermedad +
        "\",\"" +
        foto +
        "\");");

    print("ejecutando......................");
    // condicion donde digo si el nombre esta perteneciendo en sample, que se ejecute la realidad aumentada
    if ((sample.name == "Presenting Details")) {
      this.architectWidget.callJavascript("World.loadPoisFromJsonData();");
    }
  }

  Future<void> onLoadSuccess() async {
    loadFailed = false;
  }

  Future<void> onLoadFailed(String error) async {
    loadFailed = true;
    this.architectWidget.showAlert("Failed to load Architect World", error);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _onBackPressed();
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.transparent,
          ),
        ),
        body: Container(
            decoration: BoxDecoration(color: Colors.black),
            child: architectWidget),
      ),
    );
  }

  // REGRESAR
  Future<bool> _onBackPressed() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[50],
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

class ArViewWidget extends StatefulWidget {
  final Sample sample;
  final id;
  ArViewWidget({Key key, this.sample, this.id}) : super(key: key);
  @override
  ArViewState createState() => new ArViewState(sample: sample);
}
