class Validaciones {
  validarEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    return regExp.hasMatch(value ?? '')
        ? null
        : 'El valor ingresado no luce como un correo valido';
  }

  validarClave({String clave, String claveRepetida}) {
    String mensaje = '';
    if (clave == claveRepetida) {
      return null;
    } else {
      mensaje = "No coinciden las claves!";
    }
    return mensaje;
  }

  validarNumero({String numero}) {
    String pattern = r'^[0]*[0-9]\d{9}$';
    RegExp phoneRegex = new RegExp(pattern);
    return phoneRegex.hasMatch(numero ?? '')
        ? null
        : 'El valor ingresado no luce como un número telefónico';
    /* String mensaje = '';
  if (!val.contains(RegExp(r'[0-9]'))) {
    return "Password must contain a number";
  } */
  }

  validarNumeroCedula({String cedula}) {
    String pattern = r'[0-9]';
    RegExp phoneRegex = new RegExp(pattern);
    return phoneRegex.hasMatch(cedula ?? '')
        ? null
        : 'El valor ingresado no luce como un número de cédula';
  }
}

final validaciones = new Validaciones();
