import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/firebase/user_firebase.dart';
import '../../../domain/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(Ref ref) => UserFirebase();
