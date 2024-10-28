import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:myapp/data/models/user_model.dart' as custom_user;

class AuthRepository {
  final firebase_auth.FirebaseAuth firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  Future<void> signUp({required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        throw Exception("This password is too weak");
      } else if (e.code == "email-already-in-use") {
        throw Exception("The account already exists for that email");
      } else {
        throw Exception(e.message!);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        throw Exception("No user found for that email");
      } else if (e.code == "wrong-password") {
        throw Exception("Wrong password provided");
      } else {
        throw Exception(e.message!);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  custom_user.User? get currentUser {
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return custom_user.User.fromFirebaseUser(firebaseUser);
    }
    return null;
  }

  Stream<custom_user.User?> get userChanges {
    return firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser != null) {
        return custom_user.User(
          uid: firebaseUser.uid,
          email: firebaseUser.email ??
              'no-email@example.com', // Provide a default value or handle null appropriately
        );
      }
      return null;
    });
  }
}
