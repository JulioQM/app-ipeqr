class Enfermedad {
  int enferId;
  int persId; //cambiado
  String enferNombre;
  String enferDescMedicacion;
  String enferDescDosificacion;
  String enferDescEnfermedad;

  Enfermedad({
    this.enferId,
    this.persId,
    this.enferNombre,
    this.enferDescMedicacion,
    this.enferDescDosificacion,
    this.enferDescEnfermedad,
  });

  factory Enfermedad.fromMap(Map<String, dynamic> json) => Enfermedad(
        enferId: json["enfer_id"],
        persId: json["pers_id"],
        enferNombre: json["enfer_nombre"],
        enferDescMedicacion: json["enfer_desc_medicacion"],
        enferDescDosificacion: json["enfer_desc_dosificacion"],
        enferDescEnfermedad: json["enfer_desc_enfermedad"],
      );

// get y set

  get getPersId => this.persId;

  set setPersId(persId) => this.persId = persId;

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
