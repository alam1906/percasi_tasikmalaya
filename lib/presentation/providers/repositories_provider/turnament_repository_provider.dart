import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/data/firebase/turnament_firebase.dart';
import 'package:percasi_tasikmalaya/domain/repositories/turnament_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'turnament_repository_provider.g.dart';

@riverpod
TurnamentRepository turnamentRepository(Ref ref) => TurnamentFirebase();
