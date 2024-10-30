import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/result.dart';
import '../../domain/entities/user_model.dart';
import '../../domain/repositories/user_repository.dart';

class UserFirebase implements UserRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<Result<UserModel>> createUser(
      {required String uid,
      required String email,
      required String clubId,
      required String imageUrl,
      required int rating,
      required String role,
      required String username}) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'email': email,
      'clubId': clubId,
      'imageUrl': imageUrl,
      'rating': rating,
      'role': role,
      'username': username,
    });
    final data = await _firestore.collection('users').doc(uid).get();
    if (data.exists) {
      return Result.success(UserModel.fromJson(data.data()!));
    } else {
      return const Result.failed("Gagal menambahkan data");
    }
  }

  @override
  Future<Result<UserModel>> getUserById({required String uid}) async {
    final data = await _firestore.collection('users').doc(uid).get();
    if (data.exists) {
      return Result.success(UserModel.fromJson(data.data()!));
    } else {
      return const Result.failed("Gagal mendapatkan data");
    }
  }

  @override
  Future<Result<UserModel>> updateUser({required UserModel user}) async {
    try {
      final data = _firestore.collection('users').doc(user.uid);
      await data.update(user.toJson());

      final result = await data.get();
      if (result.exists) {
        UserModel updateUser = UserModel.fromJson(result.data()!);
        if (updateUser == user) {
          return Result.success(updateUser);
        } else {
          return const Result.failed("Gagal mengupdate data");
        }
      } else {
        return const Result.failed("Gagal mengupdate data");
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? 'Gagal mengupdate data');
    }
  }

  @override
  Future<Result<List<UserModel>>> getAllUser() async {
    List<UserModel> users = [];
    final data = await _firestore.collection('users').get();
    if (data.docs.isNotEmpty) {
      for (var e in data.docs) {
        final result = UserModel.fromJson(e.data());
        users.add(result);
      }
      return Result.success(users);
    } else {
      return const Result.failed("Gagal mengambil data user");
    }
  }
}
