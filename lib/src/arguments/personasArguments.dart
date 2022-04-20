class IdentidadArguments {
  // pertenece a usuario
  final String alias;
  final String correo;
  final String clave;
  // pertenece primera parte Identidad
  final String nombres;
  final String apellidos;
  final String cedula;
  final String telefono;
  final String fechaNacimiento;
  final String genero;

  IdentidadArguments({
    // pertenece a corrreo
    this.alias,
    this.correo,
    this.clave,
    // pertenece a identidad
    this.nombres,
    this.apellidos,
    this.cedula,
    this.telefono,
    this.fechaNacimiento,
    this.genero,
  });
}

class ResidenciaArguments {
  final String nombreProvincia;
  final String nombreCiudad;
  final String direccion;
  ResidenciaArguments(
      {this.nombreProvincia, this.nombreCiudad, this.direccion});
}

class IdPersonaArguments {
  final int persId;
  IdPersonaArguments({this.persId});
}

// id creado para llevar el id a la parte administrativa
class IdPersonaPerfilAdminArguments {
  final int id;

  IdPersonaPerfilAdminArguments({this.id});
}
