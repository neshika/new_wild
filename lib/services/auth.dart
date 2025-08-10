//flutter pub add firebase_auth
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //получааем пользователя
  User? get getCurrentUser => _firebaseAuth.currentUser;

  //подписка на изменения проверяем залогинен пользователь или нет
  Stream<User?> get getAuthStateChange => _firebaseAuth.authStateChanges();

  //login (Future - ожидаем ответа)

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      // print(error);
    }
  }

  //logout

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  //forget password
  Future<void> repearPassword({
    required String email,
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (error) {
      //  print(error);
    }
  }

  //singIn (Future - ожидаем ответа)
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      // print(error);
    }
  }
}
