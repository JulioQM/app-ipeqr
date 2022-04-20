class UsuariosArguments {
  final String nombre;
  final String correo;
  final String clave;
  UsuariosArguments({this.nombre, this.correo, this.clave});
}

class UsuarioIdArguments {
  final int idUsuario;
  UsuarioIdArguments({this.idUsuario});
}

class UsuarioIdEmailArgument {
  final int idUsuario;
  final String email;
  UsuarioIdEmailArgument({this.idUsuario, this.email});
}
