import '../../../entities/result.dart';
import '../../../entities/user_model.dart';
import '../../../repositories/auth_repository.dart';
import '../../../repositories/user_repository.dart';
import '../../usecase.dart';

class GetLoggedInUser implements UseCase<Result<UserModel>, void> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  GetLoggedInUser({required this.authRepository, required this.userRepository});
  @override
  Future<Result<UserModel>> call(void params) async {
    final data = authRepository.getLoggedInUser();
    if (data != null) {
      final result = await userRepository.getUserById(uid: data);
      if (result.isSuccess) {
        return Result.success(result.resultValue!);
      } else {
        return Result.failed(result.errorMessage!);
      }
    } else {
      return const Result.failed("tidak ada data login");
    }
  }
}
