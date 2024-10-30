import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percasi_tasikmalaya/domain/entities/turnament_model.dart';
import 'package:percasi_tasikmalaya/domain/usecase/turnament/add_turnament/add_turnament_params.dart';
import 'package:percasi_tasikmalaya/presentation/providers/usecase_provider/turnament/add_turnament_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/usecase_provider/turnament/get_turnament_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'turnament_data_provider.g.dart';

@Riverpod(keepAlive: true)
class TurnamentDataProvider extends _$TurnamentDataProvider {
  @override
  Future<List<TurnamentModel>> build() async {
    final data = ref.read(getTurnamentProvider);
    final result = await data(null);
    if (result.isSuccess) {
      return result.resultValue!;
    } else {
      return [];
    }
  }

  Future<void> refreshData() async {
    final data = ref.read(getTurnamentProvider);
    final result = await data(null);
    if (result.isSuccess) {
      state = AsyncData(result.resultValue!);
    } else {
      state =
          AsyncError(FlutterError(result.errorMessage!), StackTrace.current);
      state = AsyncData(state.value!);
    }
  }

  Future<void> addTurnament(
      {required String title, required File imageFile}) async {
    state = const AsyncLoading();
    final data = ref.read(addTurnamentProvider);
    final result =
        await data(AddTurnamentParams(title: title, imageFile: imageFile));
    if (result.isSuccess) {
      refreshData();
    } else {
      state =
          AsyncError(FlutterError(result.errorMessage!), StackTrace.current);
      state = AsyncData(state.value!);
    }
  }
}
