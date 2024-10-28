import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:percasi_tasikmalaya/domain/entities/club_model.dart';
import 'package:percasi_tasikmalaya/domain/usecase/club/add_club/add_club_params.dart';
import 'package:percasi_tasikmalaya/domain/usecase/club/update_club/update_club_params.dart';
import 'package:percasi_tasikmalaya/domain/usecase/club/update_description/update_description_params.dart';
import 'package:percasi_tasikmalaya/domain/usecase/club/update_image_club/update_image_club_params.dart';
import 'package:percasi_tasikmalaya/presentation/providers/usecase_provider/club/add_club_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/usecase_provider/club/get_all_club_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/usecase_provider/club/update_club_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/usecase_provider/club/update_description_club_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/usecase_provider/club/update_image_club_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/user_data_provider/user_data_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'club_data_provider.g.dart';

@Riverpod(keepAlive: true)
class ClubData extends _$ClubData {
  @override
  Future<List<ClubModel>?> build() async {
    final data = ref.read(getAllClubProvider);
    final result = await data(null);
    if (result.isSuccess) {
      return result.resultValue!;
    } else {
      return null;
    }
  }

  Future<void> refreshData() async {
    final data = ref.read(getAllClubProvider);
    final result = await data(null);
    if (result.isSuccess) {
      state = AsyncData(result.resultValue);
    } else {
      state = const AsyncData(null);
    }
  }

  Future<void> addClub({required String name, required String fullName}) async {
    state = const AsyncLoading();
    final data = ref.read(addClubProvider);
    final result = await data(AddClubParams(name: name, fullName: fullName));
    if (result.isSuccess) {
      refreshData();
    } else {
      state =
          AsyncError(FlutterError(result.errorMessage!), StackTrace.current);
      state = AsyncData(state.valueOrNull);
    }
  }

  Future<String?> updateImage({required File imageFile}) async {
    final data = ref.read(updateImageClubProvider);
    final result = await data(UpdateImageClubParams(imageFile: imageFile));
    if (result.isSuccess) {
      refreshData();
      return result.resultValue!;
    } else {
      state = AsyncError(
          FlutterError("gagal menambahkan image"), StackTrace.current);
      state = AsyncData(state.valueOrNull);
    }
    return null;
  }

  Future<void> updateClub({required ClubModel club}) async {
    final data = ref.read(updateClubProvider);
    final result = await data(UpdateClubParams(club: club));
    if (result.isSuccess) {
      refreshData();
      state = AsyncData(state.valueOrNull);
    } else {
      state =
          AsyncError(FlutterError(result.errorMessage!), StackTrace.current);
      state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> updateDescription(
      {required String id, required String description}) async {
    final data = ref.read(updateDescriptionProvider);
    final result =
        await data(UpdateDescriptionParams(id: id, description: description));
    if (result.isSuccess) {
      refreshData();
      ref.read(userDataProvider.notifier).getClub();
    } else {
      state = AsyncError(
          FlutterError("gagal menambahkan description"), StackTrace.current);
      state = AsyncData(state.valueOrNull);
    }
  }
}
