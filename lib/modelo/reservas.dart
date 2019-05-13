import 'package:firebase_database/firebase_database.dart'
    show DataSnapshot;

class Reservas {
  String id;
  String nombre;
  String dni;
  String fecha;
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