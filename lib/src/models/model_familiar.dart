class Familiar {
  int familId; // agregado
  int persId; // camiado
  String familNombres;
  String familApellidos;
  String familCelular;
  String familConvencional;
  String familDireccion;

  Familiar({
    this.familId, //agregado
    this.persId,
    this.familNombres,
    this.familApellidos,
    this.familCelular,
    this.familConvencional,
    this.familDireccion,
  });

  factory Familiar.fromMap(Map<String, dynamic> json) => Familiar(
        familId: json["famil_id"],
        persId: json["pers_id"],
        familNombres: json["famil_nombres"],
        familApellidos: json["famil_apellidos"],
        familCelular: json["famil_celular"],
        familConvencional: json["famil_convencional"],
        familDireccion: json["famil_direccion"],
      );
// get y setter
  get getPersId => this.persId;
  set setPersId(persId) => this.persId = persId;

  get getFamilNombres => this.familNombres;
  set setFamilNombres(familNombres) => this.familNombres = familNombres;

  get getFamilApellidos => this.familApellidos;
  set setFamilApellidos(familApellidos) => this.familApellidos = familApellidos;

  get getFamilCelular => this.familCelular;
  set setFamilCelular(familCelular) => this.familCelular = familCelular;

  get getFamilConvencional => this.familConvencional;
  set setFamilConvencional(familConvencional) =>
      this.familConvencional = familConvencional;

  get getFamilDireccion => this.familDireccion;
  set setFamilDireccion(familDireccion) => this.familDireccion = familDireccion;
}
