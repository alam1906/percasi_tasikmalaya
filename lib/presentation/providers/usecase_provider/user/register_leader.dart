import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/usecase/user/register_leader/register_leader.dart';
import '../../repositories_provider/auth_repository_provider.dart';
import '../../repositories_provider/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'register_leader.g.dart';

@riverpod
RegisterLeader registerLeader(Ref ref) => RegisterLeader(
    authRepository: ref.read(authRepositoryProvider),
    userRepository: ref.read(userRepositoryProvider));
