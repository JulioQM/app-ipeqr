class Usuario {
  int usuaId;
  int rolId;
  String usuaAlias;
  String usuaClave;
  String usuaEmail;
  String usuaFechaRegistro; // antes DateTime
  String usuaFechaActualizacion; // antes dinamyc
  String usuaEstado;
  //se agrego 24-03-2022
  String usuaCodigo;
//se agrego 27-03-2022
  String usuaCodigoCambiarClave;

  Usuario(
      {this.usuaId,
      this.rolId,
      this.usuaAlias,
      this.usuaClave,
      this.usuaEmail,
      this.usuaFechaRegistro,
      this.usuaFechaActualizacion,
      this.usuaEstado,
      this.usuaCodigo,
      this.usuaCodigoCambiarClave});

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
        usuaId: json["usua_id"],
        rolId: json["rol_id"],
        usuaAlias: json["usua_alias"],
        usuaClave: json["usua_clave"],
        usuaEmail: json["usua_email"],
        usuaFechaRegistro: json["usua_fecha_registro"],
        usuaFechaActualizacion: json["usua_fecha_actualizacion"],
        usuaEstado: json["usua_estado"],
        usuaCodigo: json["usua_codigo"],
        usuaCodigoCambiarClave: json["usua_codigo_cambiar_clave"],
      );
// accesores hay dos maneras
// get
  /*  String getUsuaAlias() {
    return this.usuaAlias;
  }

  String getUsuaClave() {
    return this.usuaClave;
  }

  String getUsuaEmail() {
    return this.usuaEmail;
  } */

  // set
  /* void setUsuaAlias(String usuaAlias) {
    this.usuaAlias = usuaAlias;
  }

  void setUsuaClave(String usuaClave) {
    this.usuaClave = usuaClave;
  }

  void setUsuaEmail(String usuaEmail) {
    this.usuaEmail = usuaEmail;
  } */

  // get
  int get getUsuaId {
    return this.usuaId;
  }

  String get getUsuaAlias {
    return this.usuaAlias;
  }

  String get getUsuaClave {
    return this.usuaClave;
  }

  String get getUsuaCodigo {
    return this.usuaCodigo;
  }

  String get getUsuaCodigoCambiarClave {
    return this.usuaCodigoCambiarClave;
  }

  String get getUsuaEmail {
    return this.usuaEmail;
  }

  // set
  set setUsuaId(int usuaId) {
    this.usuaId = usuaId;
  }

  set setUsuaAlias(String usuaAlias) {
    this.usuaAlias = usuaAlias;
  }

  set setUsuaClave(String usuaClave) {
    this.usuaClave = usuaClave;
  }

  set setUsuaCodigo(String usuaCodigo) {
    this.usuaCodigo = usuaCodigo;
  }

  set setUsuaCodigoCambiarClave(String usuaCodigoCambiarClave) {
    this.usuaCodigoCambiarClave = usuaCodigoCambiarClave;
  }

  set setUsuaEmail(String usuaEmail) {
    this.usuaEmail = usuaEmail;
  }
}
