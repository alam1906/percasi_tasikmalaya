import '../../../entities/result.dart';
import '../../../entities/user_model.dart';
import '../../../repositories/user_repository.dart';
import 'update_user_params.dart';
import '../../usecase.dart';

class UpdateUser implements UseCase<Result<UserModel>, UpdateUserParams> {
  final UserRepository userRepository;

  UpdateUser({required this.userRepository});
  @override
  Future<Result<UserModel>> call(UpdateUserParams params) {
    return userRepository.updateUser(user: params.user);
  }
}
