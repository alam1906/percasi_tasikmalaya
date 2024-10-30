import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/result.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthFirebase implements AuthRepository {
  final _auth = FirebaseAuth.instance;
  @override
  @override
  String? getEmail() {
    return _auth.currentUser?.email;
  }

  @override
  String? getLoggedInUser() => _auth.currentUser?.uid;

  @override
  Future<Result<String>> login(
      {required String email, required String password}) async {
    try {
      final data = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return Result.success(data.user!.uid);
    } on FirebaseAuthException catch (e) {
      return Result.failed(e.message!);
    }
  }

  @override
  Future<Result<void>> logout() async {
    await _auth.signOut();
    if (_auth.currentUser == null) {
      return const Result.success(null);
    } else {
      return const Result.failed("gagal sign out");
    }
  }

  @override
  Future<Result<User?>> register(
      {required String email, required String password}) async {
    try {
      final data = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return Result.success(data.user);
    } on FirebaseAuthException catch (e) {
      return Result.failed(e.message!);
    }
  }

  @override
  void deleteUser() => _auth.currentUser!.delete();
}
