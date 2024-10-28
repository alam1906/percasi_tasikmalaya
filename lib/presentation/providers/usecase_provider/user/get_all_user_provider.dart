import '../../../../domain/usecase/user/get_all_user/get_all_user.dart';
import '../../repositories_provider/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_all_user_provider.g.dart';

@riverpod
GetAllUser getAllUser(GetAllUserRef ref) =>
    GetAllUser(userRepository: ref.read(userRepositoryProvider));