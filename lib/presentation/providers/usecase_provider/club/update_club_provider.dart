import 'package:percasi_tasikmalaya/domain/usecase/club/update_club/update_club.dart';
import 'package:percasi_tasikmalaya/presentation/providers/club_data_provider/club_data_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/repositories_provider/club_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'update_club_provider.g.dart';

@riverpod
UpdateClub updateClub(UpdateClubRef ref) =>
    UpdateClub(clubRepository: ref.read(clubRepositoryProvider));
