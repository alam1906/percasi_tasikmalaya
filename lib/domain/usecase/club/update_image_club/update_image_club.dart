import 'package:percasi_tasikmalaya/domain/entities/result.dart';
import 'package:percasi_tasikmalaya/domain/repositories/club_repository.dart';
import 'package:percasi_tasikmalaya/domain/usecase/club/update_image_club/update_image_club_params.dart';
import 'package:percasi_tasikmalaya/domain/usecase/usecase.dart';

class UpdateImageClub
    implements UseCase<Result<String>, UpdateImageClubParams> {
  final ClubRepository clubRepository;

  UpdateImageClub({required this.clubRepository});
  @override
  Future<Result<String>> call(UpdateImageClubParams params) async {
    final data = await clubRepository.uploadImage(imageFile: params.imageFile);
    return Result.success(data.resultValue!);
  }
}
