import '../../../../domain/usecase/user/register_member.dart/register_member.dart';
import '../../repositories_provider/auth_repository_provider.dart';
import '../../repositories_provider/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'register_member.g.dart';

@riverpod
RegisterMember registerMember(RegisterMemberRef ref) => RegisterMember(
    authRepository: ref.read(authRepositoryProvider),
    userRepository: ref.read(userRepositoryProvider));
