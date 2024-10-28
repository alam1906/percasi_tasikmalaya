import '../../../entities/result.dart';
import '../../../entities/user_model.dart';
import '../../../repositories/auth_repository.dart';
import '../../../repositories/user_repository.dart';
import '../../usecase.dart';

part 'login_params.dart';

class Login implements UseCase<Result<UserModel>, LoginParams> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  Login({required this.authRepository, required this.userRepository});

  @override
  Future<Result<UserModel>> call(LoginParams params) async {
    final data = await authRepository.login(
        email: params.email, password: params.password);
    if (data.isSuccess) {
      final result = await userRepository.getUserById(uid: data.resultValue!);
      if (result.isSuccess) {
        return Result.success(result.resultValue!);
      } else {
        return Result.failed(result.errorMessage!);
      }
    } else {
      return Result.failed(data.errorMessage!);
    }
  }
}
