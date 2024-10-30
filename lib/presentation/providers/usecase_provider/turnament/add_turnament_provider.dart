import 'package:percasi_tasikmalaya/domain/usecase/turnament/add_turnament/add_turnament.dart';
import 'package:percasi_tasikmalaya/presentation/providers/repositories_provider/turnament_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'add_turnament_provider.g.dart';

@riverpod
AddTurnament addTurnament(AddTurnamentRef ref) =>
    AddTurnament(turnamentRepository: ref.read(turnamentRepositoryProvider));
