import 'package:percasi_tasikmalaya/domain/entities/result.dart';
import 'package:percasi_tasikmalaya/domain/entities/turnament_model.dart';
import 'package:percasi_tasikmalaya/domain/repositories/turnament_repository.dart';
import 'package:percasi_tasikmalaya/domain/usecase/usecase.dart';

class GetTurnament implements UseCase<Result<List<TurnamentModel>>, void> {
  final TurnamentRepository turnamentRepository;

  GetTurnament({required this.turnamentRepository});
  @override
  Future<Result<List<TurnamentModel>>> call(void params) async {
    final data = await turnamentRepository.getTurnament();
    if (data.isSuccess) {
      return Result.success(data.resultValue!);
    } else {
      return Result.failed(data.errorMessage!);
    }
  }
}
