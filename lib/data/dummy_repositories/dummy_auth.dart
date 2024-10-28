// import '../../domain/entities/result.dart';
// import '../../domain/repositories/auth_repository.dart';

// class DummyAuth implements AuthRepository {
//   @override
//   String? getLoggedInUser() {
//     // TODO: implement getLoggedInUser
//     throw UnimplementedError();
//   }

//   @override
//   Future<Result<String>> login(
//       {required String email, required String password}) async {
//     await Future.delayed(const Duration(seconds: 1));
//     return const Result.success("ID : 123123");

//     // return const Result.failed("gagal menambahkan login");
//   }

//   @override
//   Future<Result<void>> logout() {
//     // TODO: implement logout
//     throw UnimplementedError();
//   }

//   @override
//   Future<Result<String>> register(
//       {required String email, required String password}) async {
//     await Future.delayed(const Duration(seconds: 1));
//     return const Result.success('ID : 123123');

//     // return const Result.failed("gagal menambahkan user");
//   }

//   @override
//   String? getEmail() {
//     // TODO: implement getEmail
//     throw UnimplementedError();
//   }
// }
