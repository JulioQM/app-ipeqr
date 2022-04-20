class Persona {
  int persId; // estaba String
  int usuaId; // estaba String
  String persIdentificacion;
  String persNombres;
  String persApellidos;
  String persCelular;
  String persFechaNacimiento;
  String persDiaNacimiento; // agregado
  String persSexo;
  int provId; // estaba String
  int ciudId; // estaba String
  String provNombre; // agregado
  String ciudNombre; // agregado
  String persDireccion;
  String persLinkQr;
  String persFoto;
  // mas datos de perfil de enfermedad y familiar
  String familNombresCompletos;
  String familCelular;
  String familDireccion;
  String enferNombre;
  String enferDescMedicacion;
  String enferDescDosificacion;
  String enferDescEnfermedad;

  Persona({
    this.persId,
    this.usuaId,
    this.persIdentificacion,
    this.persNombres,
    this.persApellidos,
    this.persCelular,
    this.persFechaNacimiento,
    this.persDiaNacimiento,
    this.persSexo,
    this.provId,
    this.provNombre, // agregado
    this.ciudId,
    this.ciudNombre, // agregado
    this.persDireccion,
    this.persLinkQr,
    this.persFoto,
    // mas datos de perfil de enfermedad y familiar
    this.familNombresCompletos,
    this.familCelular,
    this.familDireccion,
    this.enferNombre,
    this.enferDescMedicacion,
    this.enferDescDosificacion,
    this.enferDescEnfermedad,
  });

  factory Persona.fromMap(Map<String, dynamic> json) => Persona(
        persId: json["pers_id"],
        usuaId: json["usua_id"],
        persIdentificacion: json["pers_identificacion"],
        persNombres: json["pers_nombres"],
        persApellidos: json["pers_apellidos"],
        persCelular: json["pers_celular"],
        persFechaNacimiento: (json["pers_fecha_nacimiento"]),
        persDiaNacimiento: json["pers_dia_nacimiento"],
        persSexo: json["pers_sexo"],
        provId: json["prov_id"],
        ciudId: json["ciud_id"],
        provNombre: json["prov_nombre"],
        ciudNombre: json["ciud_nombre"],
        persDireccion: json["pers_direccion"],
        persLinkQr: json["pers_link_qr"],
        persFoto: json["pers_foto"],
// mas datos de perfil de enfermedad y familiar
        familNombresCompletos: json["famil_nombresCompletos"],
        familCelular: json["famil_celular"],
        familDireccion: json["famil_direccion"],
        enferNombre: json["enfer_nombre"],
        enferDescMedicacion: json["enfer_desc_medicacion"],
        enferDescDosificacion: json["enfer_desc_dosificacion"],
        enferDescEnfermedad: json["enfer_desc_enfermedad"],
      );

// getter and setter
// nuevo get ys set
  get getPersId => this.persId;
  set setPersId(persId) => this.persId = persId;

  get getUsuaId => this.usuaId;
  set setUsuaId(usuaId) => this.usuaId = usuaId;

  get getPersIdentificacion => this.persIdentificacion;
  set setPersIdentificacion(persIdentificacion) =>
      this.persIdentificacion = persIdentificacion;

  get getPersNombres => this.persNombres;
  set setPersNombres(persNombres) => this.persNombres = persNombres;

  get getPersApellidos => this.persApellidos;
  set setPersApellidos(persApellidos) => this.persApellidos = persApellidos;

  get getPersCelular => this.persCelular;
  set setPersCelular(persCelular) => this.persCelular = persCelular;

  get getPersFechaNacimiento => this.persFechaNacimiento;

  set setPersFechaNacimiento(persFechaNacimiento) =>
      this.persFechaNacimiento = persFechaNacimiento;

  get getPersSexo => this.persSexo;
  set setPersSexo(persSexo) => this.persSexo = persSexo;
// se anadieron get y set de provnombre y ciudnombre fecha 2022-14-04
  get getProvId => this.provId;
  set setProvId(provId) => this.provId = provId;

  get getProvNombre => this.provNombre;
  set setProvNombre(provNombre) => this.provNombre = provNombre;

  get getCiudId => this.ciudId;
  set setCiudId(ciudId) => this.ciudId = ciudId;

  get getCiudNombre => this.ciudNombre;
  set setCiudNombre(ciudNombre) => this.ciudNombre = ciudNombre;

  get getPersDireccion => this.persDireccion;
  set setPersDireccion(persDireccion) => this.persDireccion = persDireccion;

  get getPersLinkQr => this.persLinkQr;
  set setPersLinkQr(persLinkQr) => this.persLinkQr = persLinkQr;

  get getPersFoto => this.persFoto;
  set setPersFoto(persFoto) => this.persFoto = persFoto;
  // otros datos

  get getFamilNombresCompletos => this.familNombresCompletos;

  set setFamilNombresCompletos(String familNombresCompletos) =>
      this.familNombresCompletos = familNombresCompletos;

  get getFamilCelular => this.familCelular;

  set setFamilCelular(familCelular) => this.familCelular = familCelular;

  get getFamilDireccion => this.familDireccion;

  set setFamilDireccion(familDireccion) => this.familDireccion = familDireccion;

  get getEnferNombre => this.enferNombre;

  set setEnferNombre(enferNombre) => this.enferNombre = enferNombre;

  get getEnferDescMedicacion => this.enferDescMedicacion;

  set setEnferDescMedicacion(enferDescMedicacion) =>
      this.enferDescMedicacion = enferDescMedicacion;

  get getEnferDescDosificacion => this.enferDescDosificacion;

  set setEnferDescDosificacion(enferDescDosificacion) =>
      this.enferDescDosificacion = enferDescDosificacion;

  get getEnferDescEnfermedad => this.enferDescEnfermedad;

  set setEnferDescEnfermedad(enferDescEnfermedad) =>
      this.enferDescEnfermedad = enferDescEnfermedad;
}
