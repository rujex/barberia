import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_demo/models/user.dart';

class StateModel {
  FirebaseUser firebaseUserAuth;
  User user;

  StateModel({
    this.firebaseUserAuth,
    this.user,
  });
}