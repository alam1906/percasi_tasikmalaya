import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/usecase/user/login/login.dart';
import '../../repositories_provider/auth_repository_provider.dart';
import '../../repositories_provider/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'login_provider.g.dart';

@riverpod
Login login(Ref ref) => Login(
    authRepository: ref.read(authRepositoryProvider),
    userRepository: ref.read(userRepositoryProvider));
