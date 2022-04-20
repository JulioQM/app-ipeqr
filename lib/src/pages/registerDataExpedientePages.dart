import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/arguments/exportArguments.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:fronted_lookhere/src/widgets/exportWidgets.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterExpedientePages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Scaffold(
      body: LoginBackground(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(height: /*  150 */ responsive.altop(35)),
                CardContainer(
                  // llamo mi widget contenedor
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: /* 10 */ responsive.altop(5)),
                      Text(
                        'Ingrese su expediente médico',
                        style: /* Theme.of(context).textTheme.headline6 */ TextStyle(
                            fontSize: responsive.diagonalp(2.8),
                            color: Colors.black45),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: /* 10 */ responsive.altop(5)),
                      ChangeNotifierProvider(
                        // crea una instancia changeNotifierProvider
                        create: (_) => ExpedienteProvider(),
                        child: _FormularioRegister(),
                      )
                    ],
                  ),
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
  bool tieneEnfermedad = false;
  String ninguno = '';
  //
  final TextEditingController enfer = TextEditingController();
  final TextEditingController desenfer = TextEditingController();
  final TextEditingController desmed = TextEditingController();
  final TextEditingController desdos = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // con esta variable puedo ingresar a la instancia de la clase ExpedienteFormProvider
    final expedienteForm = Provider.of<ExpedienteProvider>(context);
    final IdPersonaArguments argUsuario =
        ModalRoute.of(context).settings.arguments;
    final Responsive responsives = Responsive.of(context);

    return Container(
      child: Form(
        key: expedienteForm.formKey,
        // activar validacion en modo de interacion
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            // contenedor con checkbox
            // Agregar checkbox que cuando activo autocompleto en los campos NINGUNO, caso contrario campo vacio
            Container(
              color: Colors.blueGrey[50],
              /*  margin: EdgeInsets.symmetric(horizontal: 50),
              padding: EdgeInsets.symmetric(horizontal: 7), */
              margin:
                  EdgeInsets.symmetric(horizontal: responsives.diagonalp(2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿Estás enfermo?  ',
                  ),
                  Text(
                    'No',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Checkbox(
                    activeColor: Colors.deepPurple,
                    checkColor: Colors.white,
                    value: tieneEnfermedad,
                    onChanged: (value) {
                      setState(() {});
                      tieneEnfermedad = value;
                      if (tieneEnfermedad == true) {
                        ninguno = 'NINGUNO';
                        desenfer.text = ninguno;
                        enfer.text = ninguno;
                        desmed.text = ninguno;
                        desdos.text = ninguno;
                      } else {
                        enfer.text = '';
                        desenfer.text = '';
                        desmed.text = '';
                        desdos.text = '';
                      }
                    },
                  ),
                ],
              ),
            ),

            // caja de texto para el atributo nombre enfermedad
            TextFormField(
              enabled: (enfer.text.length == 0) ? true : false,
              controller: enfer,
              autocorrect: true,
              keyboardType: TextInputType.text,
              inputFormatters: [UpperCaseTextFormatter()],
              decoration: InputDecorations.inputDecoration(
                  labelText: 'Enfermedad',
                  hintText: 'Ingrese su enfermedad',
                  prefixIcon: Icons.medical_services_outlined),
              // agrego el valor de las cajas de texto a las propiedades del provider Expediente
              onChanged: (value) => expedienteForm
                  .managerExpediente.setEnferNombre = value.trim(),
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'El campo es obligatoria';
              },
            ),
            SizedBox(height: 20),
            // caja de texto para el atributo de descripción de la enfermedad
            TextFormField(
                enabled: (desenfer.text.length == 0) ? true : false,
                controller: desenfer,
                maxLines: 2,
                autocorrect: true,
                keyboardType: TextInputType.text,
                inputFormatters: [UpperCaseTextFormatter()],
                decoration: InputDecorations.inputDecoration(
                    labelText: 'Describa la enfermedad',
                    hintText: 'Descripción de la enfermedad',
                    prefixIcon: Icons.medical_services_outlined),
                // agrego el valor de las cajas de texto a las propiedades del provider Expediente
                onChanged: (value) => expedienteForm
                    .managerExpediente.setEnferDescEnfermedad = value.trim(),
                validator: (value) {
                  return (value != null && value.isNotEmpty)
                      ? null
                      : 'El campo es obligatoria';
                }),
            SizedBox(height: 20),
            // caja de texto para el atributo de descripción de medicación
            TextFormField(
                enabled: (desmed.text.length == 0) ? true : false,
                controller: desmed,
                maxLines: 2,
                autocorrect: true,
                keyboardType: TextInputType.text,
                inputFormatters: [UpperCaseTextFormatter()],
                decoration: InputDecorations.inputDecoration(
                    labelText: 'Describa la Medicación',
                    hintText: 'Usa alguna medicicación',
                    prefixIcon: Icons.medical_services_outlined),
                // agrego el valor de las cajas de texto a las propiedades del provider Expediente
                onChanged: (value) {
                  expedienteForm.managerExpediente.setEnferDescMedicacion =
                      value.trim();
                },
                validator: (value) {
                  return (value != null && value.isNotEmpty)
                      ? null
                      : 'El campo es obligatoria';
                }),
            SizedBox(height: 20),
            // caja de texto para el atributo de descripción de docificación
            TextFormField(
                enabled: (desdos.text.length == 0) ? true : false,
                controller: desdos,
                maxLines: 2,
                autocorrect: true,
                keyboardType: TextInputType.text,
                inputFormatters: [UpperCaseTextFormatter()],
                decoration: InputDecorations.inputDecoration(
                    labelText: 'Describa la Dosificación',
                    hintText: 'Usa algún tratamiento',
                    prefixIcon: Icons.medical_services_outlined),
                // agrego el valor de las cajas de texto a las propiedades del provider Expediente
                onChanged: (value) => expedienteForm
                    .managerExpediente.setEnferDescDosificacion = value.trim(),
                validator: (value) {
                  return (value != null && value.isNotEmpty)
                      ? null
                      : 'El campo es obligatoria';
                }),
            SizedBox(height: /* 30 */ responsives.altop(5)),
            // Sección de boton
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
                expedienteForm.isLoading ? 'Espere..' : "Finalizar",
                style: TextStyle(
                    color: Colors.white, fontSize: responsives.diagonalp(1.6)),
              ),
              onPressed: expedienteForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus(); // bloquea mi boton
                      if (!expedienteForm.isValidForm()) return;
                      expedienteForm.isLoading = true;

                      /*  print(argUsuario.persId); */
                      // en este aparatado llamo a mis entidades de tipo set, para llevar los datos
                      expedienteForm.managerExpediente.setPersId =
                          argUsuario.persId;
                      expedienteForm.managerExpediente.setEnferNombre =
                          enfer.text;
                      expedienteForm.managerExpediente.setEnferDescEnfermedad =
                          desenfer.text;
                      expedienteForm.managerExpediente.setEnferDescMedicacion =
                          desmed.text;
                      expedienteForm.managerExpediente
                          .setEnferDescDosificacion = desdos.text;
                      // duracion del efecto, animacion
                      /* await Future.delayed(Duration(seconds: 2)); */
                      await Future.delayed(Duration(milliseconds: 1000));
                      RespuestaModel respuesta =
                          await expedienteForm.registrarExpediente();
                      print(respuesta.data);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'miperfilRegistro', (Route<dynamic> route) => false,
                          arguments:
                              IdPersonaArguments(persId: argUsuario.persId));
                      /*   Navigator.pushReplacementNamed(
                          context, 'miperfilRegistro',
                          arguments:
                              IdPersonaArguments(persId: argUsuario.persId)); */
                    },
            )
          ],
        ),
      ),
    );
  }
}
