import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class User {
  final String uid;
  final String email;

  User({required this.uid, required this.email});

  factory User.fromFirebaseUser(firebase_auth.User firebaseUser) {
    return User(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
    );
  }
}