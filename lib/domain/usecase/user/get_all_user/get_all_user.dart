import '../../../entities/result.dart';
import '../../../entities/user_model.dart';
import '../../../repositories/user_repository.dart';
import '../../usecase.dart';

class GetAllUser implements UseCase<Result<List<UserModel>>, void> {
  final UserRepository userRepository;

  GetAllUser({required this.userRepository});
  @override
  Future<Result<List<UserModel>>> call(void params) async {
    final data = await userRepository.getAllUser();
    if (data.isSuccess) {
      return Result.success(data.resultValue!);
    } else {
      return Result.failed(data.errorMessage!);
    }
  }
}
