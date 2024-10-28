import '../../../../domain/usecase/user/get_email/get_email.dart';
import '../../repositories_provider/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_email_provider.g.dart';

@riverpod
GetEmail getEmail(GetEmailRef ref) =>
    GetEmail(authRepository: ref.read(authRepositoryProvider));
