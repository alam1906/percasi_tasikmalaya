import 'package:percasi_tasikmalaya/domain/entities/club_model.dart';
import 'package:percasi_tasikmalaya/domain/entities/result.dart';
import 'package:percasi_tasikmalaya/domain/repositories/club_repository.dart';
import 'package:percasi_tasikmalaya/domain/usecase/club/update_club/update_club_params.dart';
import 'package:percasi_tasikmalaya/domain/usecase/usecase.dart';

class UpdateClub implements UseCase<Result<ClubModel>, UpdateClubParams> {
  final ClubRepository clubRepository;

  UpdateClub({required this.clubRepository});
  @override
  Future<Result<ClubModel>> call(UpdateClubParams params) async {
    return clubRepository.updateClub(club: params.club);
  }
}
