import 'package:cloud_firestore/cloud_firestore.dart';
    show DataSnapshot;

class Reservas {
  String id;
  String nombre;
  String dni;
  Timestamp fecha;
  String movil;
  String domicilio;
  String arreglo;

  Reservas(this.nombre, this.dni, this.fecha, this.movil,
      this.domicilio, this.arreglo);

  Reservas.fromSnapShot(DataSnapshot snapshot) :
    nombre = snapshot.value['nombre'],
    dni = snapshot.value['dni'],
    domicilio = snapshot.value['domicilio'],
    fecha = snapshot.value['fecha'],
    arreglo = snapshot.value['arreglo'],
    movil = snapshot.value['movil'];

    toJson() {
      return {
        "nombre": nombre,
        "dni": dni,
        "domicilio": domicilio,
        "fecha": fecha,
        "arreglo": arreglo,
        "movil": movil,
      };
  }
}