import 'package:percasi_tasikmalaya/domain/usecase/club/get_all_club/get_all_club.dart';
import 'package:percasi_tasikmalaya/presentation/providers/repositories_provider/club_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_all_club_provider.g.dart';

@riverpod
GetAllClub getAllClub(GetAllClubRef ref) =>
    GetAllClub(clubRepository: ref.read(clubRepositoryProvider));
