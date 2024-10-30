import 'dart:io';

import 'package:percasi_tasikmalaya/domain/entities/result.dart';
import 'package:percasi_tasikmalaya/domain/entities/turnament_model.dart';

abstract interface class TurnamentRepository {
  Future<Result<void>> addTurnament(
      {required String title, required File imageFile});
  Future<Result<List<TurnamentModel>>> getTurnament();
}
