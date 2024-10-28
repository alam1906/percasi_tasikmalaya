import 'package:percasi_tasikmalaya/domain/entities/result.dart';
import 'package:percasi_tasikmalaya/domain/repositories/club_repository.dart';
import 'package:percasi_tasikmalaya/domain/usecase/club/add_club/add_club_params.dart';
import 'package:percasi_tasikmalaya/domain/usecase/usecase.dart';

class AddClub implements UseCase<Result<void>, AddClubParams> {
  final ClubRepository clubRepository;

  AddClub({required this.clubRepository});
  @override
  Future<Result<void>> call(AddClubParams params) async {
    final data = await clubRepository.addClub(
        name: params.name, fullName: params.fullName);
    if (data.isSuccess) {
      return data;
    } else {
      return Result.failed(data.errorMessage!);
    }
  }
}
