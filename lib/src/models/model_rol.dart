class Rol {
  int rolId;
  String rolNombre;
  Rol({this.rolId, this.rolNombre});
  factory Rol.fromMap(Map<String, dynamic> json) => Rol(
        rolId: json["rol_id"],
        rolNombre: json["rol_nombre"],
      );
// get de rol id
  int get getRolId {
    return this.rolId;
  }

  // set de rol id
  set setRolId(int rolId) {
    this.rolId = rolId;
  }

// get de rol nombre
  String get getRolNombre {
    return this.rolNombre;
  }

  // set de rol nombre
  set setRolNombre(String rolNombre) {
    this.rolNombre = rolNombre;
  }
}
