import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
// Clase que implementa los metodos de autenticación
abstract class BaseAuth {
  Future<String> signIn( String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Inicia sesion con email y contraseña
  // se pasa por parametro el email y la contraseña
  Future<String> signIn(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }
  // registra el usuario a traves del email y contraseña
  Future<String> signUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return user.uid;
  }
  // obtiene el usuario conectado
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }
  // método para cerrar sesión
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
  // método para enviar el correo de verificación
  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }
  // devuelve el email verificado
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

}