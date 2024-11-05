import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/usecase/user/logout/logout.dart';
import '../../repositories_provider/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'logout_provider.g.dart';

@riverpod
Logout logout(Ref ref) =>
    Logout(authRepository: ref.read(authRepositoryProvider));
