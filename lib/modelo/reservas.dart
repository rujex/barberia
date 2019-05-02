class Reservas {
  String _id;
  String _nombre;
  String _apellido1;
  String _apellido2;
  String _dni;
  String _domicilio;
  String _tipo;

  Reservas(this._id, this._nombre, this._apellido1, this._apellido2, this._dni,
      this._domicilio, this._tipo);

  /// Mapeo de objetos
  Reservas.map(dynamic obj){
    this._nombre = obj['nombre'];
    this._apellido1 = obj['apellido1'];
    this._apellido2 = obj['apellido2'];
    this._dni = obj['dni'];
    this._domicilio = obj['domicilio'];
    this._tipo = obj['tipo'];
  }

  String get id => _id;
  String get nombre => _nombre;
  String get apellido1 => _apellido1;
  String get apellido2 => _apellido2;
  String get dni => _dni;
  String get domicilio => _domicilio;
  String get tipo => _tipo;

  Reservas.fromSnapShot(dynamic snapshot) {
    _id = snapshot.key;
    _nombre = snapshot.value['nombre'];
    _apellido1 = snapshot.value['apellido1'];
    _apellido2 = snapshot.value['apellido2'];
    _dni = snapshot.value['dni'];
    _domicilio = snapshot.value['domicilio'];
    _tipo = snapshot.value['tipo'];
  }
}