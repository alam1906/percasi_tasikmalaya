import '../../../entities/result.dart';
import '../../../repositories/auth_repository.dart';
import '../../usecase.dart';

class Logout implements UseCase<Result<void>, void> {
  final AuthRepository authRepository;

  Logout({required this.authRepository});
  @override
  Future<Result<void>> call(void _) {
    return authRepository.logout();
  }
}
