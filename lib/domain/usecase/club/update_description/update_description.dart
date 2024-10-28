import 'package:percasi_tasikmalaya/domain/entities/result.dart';
import 'package:percasi_tasikmalaya/domain/repositories/club_repository.dart';
import 'package:percasi_tasikmalaya/domain/usecase/club/update_description/update_description_params.dart';
import 'package:percasi_tasikmalaya/domain/usecase/usecase.dart';

class UpdateDescription
    implements UseCase<Result<void>, UpdateDescriptionParams> {
  final ClubRepository clubRepository;

  UpdateDescription({required this.clubRepository});
  @override
  Future<Result<void>> call(UpdateDescriptionParams params) async {
    await clubRepository.updateDescripition(
        description: params.description, id: params.id);
    return const Result.success(null);
  }
}
