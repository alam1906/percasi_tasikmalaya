import '../../../entities/result.dart';
import '../../../entities/user_model.dart';
import '../../../repositories/auth_repository.dart';
import '../../../repositories/user_repository.dart';
import '../../usecase.dart';
part 'register_leader_params.dart';

class RegisterLeader
    implements UseCase<Result<UserModel>, RegisterLeaderParams> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  RegisterLeader({required this.authRepository, required this.userRepository});
  @override
  Future<Result<UserModel>> call(RegisterLeaderParams params) async {
    final data = await authRepository.register(
        email: params.email, password: params.password);
    if (data.isSuccess) {
      final result = await userRepository.createUser(
          uid: data.resultValue!,
          clubId: params.clubId,
          imageUrl: params.imageUrl,
          rating: params.rating,
          role: params.role,
          username: params.username);
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
