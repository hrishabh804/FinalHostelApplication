import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostel_project/services/user_roles_firestore.dart';
abstract class BaseAuth{
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password,String id);

  Future<FirebaseUser> getCurrentUser();

  // Future<void> sendEmailVerification();

  Future<void> signOut();

// Future<bool> isEmailVerified();

}
RoleFirestoreService role = RoleFirestoreService();
class Auth implements BaseAuth{
  final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    role.updateUserRole(email,user.uid);
    return user.uid;
  }
   Future<String> signUp(String email, String password, String id) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    role.updateUserRole(email,user.uid);
    return user.uid;

  }
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }
  Future<void> signOut() async{
    return _firebaseAuth.signOut();
  }
}