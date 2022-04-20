class Ciudad {
  int ciudId;
  int provId;
  String ciudNombre;

  Ciudad({
    this.ciudId,
    this.provId,
    this.ciudNombre,
  });

  factory Ciudad.fromMap(Map<String, dynamic> json) => Ciudad(
      ciudId: json["ciud_id"],
      provId: json["prov_id"],
      ciudNombre: json["ciud_nombre"]);
// get and set
  get getCiudId => this.ciudId;
  set setCiudId(ciudId) => this.ciudId = ciudId;

  get getProvId => this.provId;
  set setProvId(provId) => this.provId = provId;

  get getCiudNombre => this.ciudNombre;
  set setCiudNombre(ciudNombre) => this.ciudNombre = ciudNombre;
}
