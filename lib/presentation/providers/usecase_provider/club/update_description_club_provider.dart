import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/domain/usecase/club/update_description/update_description.dart';
import 'package:percasi_tasikmalaya/presentation/providers/repositories_provider/club_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'update_description_club_provider.g.dart';

@riverpod
UpdateDescription updateDescription(Ref ref) =>
    UpdateDescription(clubRepository: ref.read(clubRepositoryProvider));
