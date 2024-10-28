import 'package:percasi_tasikmalaya/domain/entities/club_model.dart';
import 'package:percasi_tasikmalaya/domain/entities/result.dart';
import 'package:percasi_tasikmalaya/domain/repositories/club_repository.dart';
import 'package:percasi_tasikmalaya/domain/usecase/usecase.dart';

class GetAllClub implements UseCase<Result<List<ClubModel>>, void> {
  final ClubRepository clubRepository;

  GetAllClub({required this.clubRepository});
  @override
  Future<Result<List<ClubModel>>> call(void params) async {
    final data = await clubRepository.getAllClub();
    if (data.isSuccess) {
      return Result.success(data.resultValue!);
    } else {
      return Result.failed(data.errorMessage!);
    }
  }
}
