import 'package:flutter/material.dart';
import 'package:fronted_lookhere/src/utils/exportUtils.dart';
import 'package:intl/intl.dart';

class DataCalendars extends StatefulWidget {
  @override
  _DataCalendarsState createState() => _DataCalendarsState();
}

TextEditingController inputFielDateController = new TextEditingController();

class _DataCalendarsState extends State<DataCalendars> {
/*   String fecha = ''; */
  @override
  void initState() {
    super.initState();
    inputFielDateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: crearfechas(context),
    );
  }

  Widget crearfechas(BuildContext context) {
    return TextFormField(
      controller: inputFielDateController,
      enableInteractiveSelection: false,
      decoration: InputDecorations.inputDecoration(
          hintText: 'Fecha de nacmiento',
          labelText: 'Fecha de nacimiento',
          prefixIcon: Icons.calendar_today),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        selectDate(context);
      },
    );
  }

  selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    var now = new DateTime.now();
    var formatterAno = new DateFormat('y');
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(int.parse(formatterAno.format(now)) - 5),
        firstDate: DateTime(int.parse(formatterAno.format(now)) - 75),
        lastDate: DateTime(int.parse(formatterAno.format(now)) - 5),
        locale: Locale('es', 'ES'));
    if (picked != null) {
      setState(() {
        //fecha = picked.toString();
        /* inputFielDateController.text = fecha; */
        selectedDate = picked;
        inputFielDateController.text =
            "${selectedDate.toLocal()}".split(' ')[0];

        print('.......');
        print("${selectedDate.toLocal()}".split(' ')[0]);
        print('.......');
      });
    }
  }
}
