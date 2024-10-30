import 'package:percasi_tasikmalaya/domain/entities/result.dart';
import 'package:percasi_tasikmalaya/domain/repositories/turnament_repository.dart';
import 'package:percasi_tasikmalaya/domain/usecase/turnament/add_turnament/add_turnament_params.dart';
import 'package:percasi_tasikmalaya/domain/usecase/usecase.dart';

class AddTurnament implements UseCase<Result<void>, AddTurnamentParams> {
  final TurnamentRepository turnamentRepository;

  AddTurnament({required this.turnamentRepository});
  @override
  Future<Result<void>> call(AddTurnamentParams params) async {
    final data = await turnamentRepository.addTurnament(
        title: params.title, imageFile: params.imageFile);
    if (data.isSuccess) {
      return const Result.success(null);
    } else {
      return Result.failed(data.errorMessage!);
    }
  }
}
