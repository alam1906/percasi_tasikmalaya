import 'package:percasi_tasikmalaya/domain/repositories/auth_repository.dart';

class DeleteUser {
  final AuthRepository authRepository;

  DeleteUser({required this.authRepository});

  void deleteUser() {
    return authRepository.deleteUser();
  }
}
