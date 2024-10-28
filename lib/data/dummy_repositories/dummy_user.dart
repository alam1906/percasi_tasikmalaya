// import '../../domain/entities/result.dart';
// import '../../domain/entities/user_model.dart';
// import '../../domain/repositories/user_repository.dart';

// class DummyUser implements UserRepository {
//   @override
//   Future<Result<UserModel>> getUserById({
//     required String uid,
//   }) async {
//     await Future.delayed(const Duration(seconds: 1));
//     return Result.success(UserModel(
//         uid: uid,
//         username: 'alam',
//         role: 'admin',
//         rating: 123,
//         club: 'MCC',
//         imageUrl: 'www.google.com'));

//     // return const Result.failed("gagal menambahkan data");
//   }

//   @override
//   Future<Result<UserModel>> createLeader(
//       {required String uid,
//       required String club,
//       required String imageUrl,
//       required int rating,
//       required String role,
//       required String username}) async {
//     await Future.delayed(const Duration(seconds: 1));
//     return Result.success(UserModel(
//         uid: uid,
//         username: username,
//         role: role,
//         rating: rating,
//         club: club,
//         imageUrl: imageUrl));

//     // return const Result.failed("gagal menambahkan data");
//   }

//   @override
//   Future<Result<UserModel>> createMember(
//       {required String uid,
//       required String club,
//       required String imageProfile,
//       required int rating,
//       required String role,
//       required String username}) {
//     // TODO: implement createMember
//     throw UnimplementedError();
//   }
// }
