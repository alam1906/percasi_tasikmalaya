import 'package:firebase_auth/firebase_auth.dart';

import '../entities/result.dart';

abstract interface class AuthRepository {
  Future<Result<String>> login(
      {required String email, required String password});
  Future<Result<User?>> register(
      {required String email, required String password});

  Future<Result<void>> logout();
  String? getLoggedInUser();
  String? getEmail();
  void deleteUser();
}
