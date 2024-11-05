import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/domain/usecase/turnament/get_turnament/get_turnament.dart';
import 'package:percasi_tasikmalaya/presentation/providers/repositories_provider/turnament_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_turnament_provider.g.dart';

@riverpod
GetTurnament getTurnament(Ref ref) =>
    GetTurnament(turnamentRepository: ref.read(turnamentRepositoryProvider));
