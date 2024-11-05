import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/data/firebase/club_firebase.dart';
import 'package:percasi_tasikmalaya/domain/repositories/club_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'club_repository_provider.g.dart';

@riverpod
ClubRepository clubRepository(Ref ref) => ClubFirebase();
