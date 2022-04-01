import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  User? checkUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<User?> logIn() async {
    try {
      return (await FirebaseAuth.instance.signInAnonymously()).user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> logOut() async {
    await FirebaseAuth.instance.signOut();
    return FirebaseAuth.instance.currentUser;
  }
}
