import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/models/exportModels.dart';
import 'package:fronted_lookhere/src/provider/exportProvider.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:provider/provider.dart';

class FutureBuilderLocalidad extends StatefulWidget {
  @override
  _FutureBuilderLocalidadState createState() => _FutureBuilderLocalidadState();
}

int miprovincia;
int miciudad;

class _FutureBuilderLocalidadState extends State<FutureBuilderLocalidad> {
  @override
  void initState() {
    super.initState();
    miprovincia = null;
    miciudad = null;
  }

  @override
  Widget build(BuildContext context) {
    final provincia = Provider.of<ProvinciaProvider>(context, listen: true);
    final ciudad = Provider.of<CiudadProvider>(context);
    return Container(
      child: Column(
        children: <Widget>[
          FutureBuilder<List<Provincia>>(
              future: provincia.getProvincias(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Provincia>> snapshot) {
                List<Provincia> prov = snapshot.data ?? [];
                if (!snapshot.hasData) return CircularProgressIndicator();
                return DropdownButtonFormField<int>(
                  decoration: InputDecorations.inputDecoration(
                      prefixIcon: Icons.select_all),
                  value: miprovincia,
                  hint: Text('Seleccione una  Provincia'),
                  onChanged: (opt) {
                    setState(() {
                      miprovincia = opt;
                      miciudad = null;
                      print('idprovincia....' + miprovincia.toString());
                    });
                  },
                  items: [
                    for (Provincia provincia in prov)
                      DropdownMenuItem(
                        value: provincia.provId,
                        child: Text(provincia.provNombre),
                      ),
                  ],
                  isExpanded: true,
                );
              }),
          SizedBox(
            height: 20,
          ),
          FutureBuilder<List<Ciudad>>(
            future: (miprovincia != null)
                ? ciudad.getListaCiudades(miprovincia)
                : null,
            initialData: [],
            builder:
                (BuildContext context, AsyncSnapshot<List<Ciudad>> snapshot) {
              List<Ciudad> ciud = snapshot.data ?? [];
              /*  if (!snapshot.hasData) return CircularProgressIndicator(); */
              return DropdownButtonFormField<int>(
                decoration: InputDecorations.inputDecoration(
                    prefixIcon: Icons.select_all),
                value: miciudad,
                hint: Text('Seleccione una  Ciudad'),
                onChanged: (opt) {
                  setState(() {
                    miciudad = opt;
                    print('idprovincia....' + miciudad.toString());
                  });
                },
                items: [
                  for (Ciudad ciudad in ciud)
                    DropdownMenuItem(
                      value: ciudad.ciudId,
                      child: Text(ciudad.ciudNombre),
                    ),
                ],
                isExpanded: true,
              );
            },
          ),
        ],
      ),
    );
  }
}

final retornoProvincia = miprovincia;
final retornoCiudad = miciudad;
