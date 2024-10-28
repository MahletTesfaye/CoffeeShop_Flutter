import 'package:myapp/data/models/user_model.dart';

abstract class AuthRepository {
  Future<void> signUp({required String email, required String password});
  Future<void> login({required String email, required String password});
  Future<void> signOut();
  User? get currentUser;
  Stream<User?> get userChanges;
}
