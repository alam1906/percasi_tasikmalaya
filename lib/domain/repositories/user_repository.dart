import '../entities/result.dart';
import '../entities/user_model.dart';

abstract interface class UserRepository {
  Future<Result<UserModel>> getUserById({
    required String uid,
  });
  Future<Result<List<UserModel>>> getAllUser();
  Future<Result<UserModel>> createUser(
      {required String uid,
      required String clubId,
      required String imageUrl,
      required int rating,
      required String role,
      required String username});
  Future<Result<UserModel>> updateUser({required UserModel user});
}
