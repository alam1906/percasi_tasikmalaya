import 'package:percasi_tasikmalaya/domain/entities/result.dart';
import 'package:percasi_tasikmalaya/domain/repositories/club_repository.dart';
import 'package:percasi_tasikmalaya/domain/usecase/club/update_member/update_member_params.dart';
import 'package:percasi_tasikmalaya/domain/usecase/usecase.dart';

class UpdateMember implements UseCase<Result<void>, UpdateMemberParams> {
  final ClubRepository clubRepository;

  UpdateMember({required this.clubRepository});
  @override
  Future<Result<void>> call(UpdateMemberParams params) async {
    return await clubRepository.updateMember(
        id: params.id, isLeader: params.isLeader);
  }
}
