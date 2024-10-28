import '../../../entities/result.dart';
import '../../../repositories/auth_repository.dart';
import '../../usecase.dart';

class GetEmail implements UseCase<Result<String>, void> {
  final AuthRepository authRepository;

  GetEmail({required this.authRepository});
  @override
  Future<Result<String>> call(void params) async {
    final data = authRepository.getEmail();
    if (data != null) {
      return Result.success(data);
    } else {
      return const Result.failed("Tidak ada data");
    }
  }
}
