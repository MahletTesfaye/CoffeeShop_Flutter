import 'package:firebase_auth/firebase_auth.dart';

abstract class GoogleSignInRepository {
  Future<UserCredential?> signInWithGoogle();
}
