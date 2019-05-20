import 'package:cloud_firestore/cloud_firestore.dart';

class crudmethods{
    Future<void> addData(data) async{
      Firestore.instance.collection('reservas').add(data);
    }
}

