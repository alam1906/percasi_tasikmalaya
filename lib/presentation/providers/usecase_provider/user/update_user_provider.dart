import '../../../../domain/usecase/user/update_user/update_user.dart';
import '../../repositories_provider/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'update_user_provider.g.dart';

@riverpod
UpdateUser updateUser(UpdateUserRef ref) =>
    UpdateUser(userRepository: ref.read(userRepositoryProvider));
