import 'register_member_params.dart';
import '../../../entities/result.dart';
import '../../../entities/user_model.dart';
import '../../../repositories/auth_repository.dart';
import '../../../repositories/user_repository.dart';
import '../../usecase.dart';

class RegisterMember
    implements UseCase<Result<UserModel>, RegisterMemberParams> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  RegisterMember({required this.authRepository, required this.userRepository});
  @override
  Future<Result<UserModel>> call(RegisterMemberParams params) async {
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
