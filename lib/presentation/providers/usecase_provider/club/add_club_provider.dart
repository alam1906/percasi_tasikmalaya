import 'package:percasi_tasikmalaya/domain/usecase/club/add_club/add_club.dart';
import 'package:percasi_tasikmalaya/presentation/providers/repositories_provider/club_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'add_club_provider.g.dart';

@riverpod
AddClub addClub(AddClubRef ref) =>
    AddClub(clubRepository: ref.read(clubRepositoryProvider));
