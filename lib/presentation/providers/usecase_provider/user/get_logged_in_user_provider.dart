import '../../../../domain/usecase/user/get_logged_in_user/get_logged_in_user.dart';
import '../../repositories_provider/auth_repository_provider.dart';
import '../../repositories_provider/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_logged_in_user_provider.g.dart';

@riverpod
GetLoggedInUser getLoggedInUser(GetLoggedInUserRef ref) => GetLoggedInUser(
    authRepository: ref.read(authRepositoryProvider),
    userRepository: ref.read(userRepositoryProvider));
