import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/domain/usecase/user/delete_user/delete_user.dart';
import 'package:percasi_tasikmalaya/presentation/providers/repositories_provider/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'delete_user_provider.g.dart';

@riverpod
void deleteUser(Ref ref) =>
    DeleteUser(authRepository: ref.read(authRepositoryProvider));
