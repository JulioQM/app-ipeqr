class Provincia {
  int provId;
  String provNombre;

  Provincia({
    this.provId,
    this.provNombre,
  });

  factory Provincia.fromMap(Map<String, dynamic> json) => Provincia(
        provId: json["prov_id"],
        provNombre: json["prov_nombre"],
      );

// get y set
  get getProvId => this.provId;
  set setProvId(provId) => this.provId = provId;

  get getProvNombre => this.provNombre;
  set setProvNombre(String provNombre) => this.provNombre = provNombre;
}
