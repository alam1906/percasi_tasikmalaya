import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/firebase/auth_firebase.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_repository_provider.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) => AuthFirebase();
