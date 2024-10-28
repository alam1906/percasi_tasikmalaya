import 'dart:io';

import 'package:percasi_tasikmalaya/domain/entities/club_model.dart';

import '../entities/result.dart';

abstract interface class ClubRepository {
  Future<Result<void>> addClub(
      {required String name, required String fullName});
  Future<Result<List<ClubModel>>> getAllClub();
  Future<Result<void>> updateMember(
      {required String id, required bool isLeader});
  Future<Result<String>> uploadImage({required File imageFile});
  Future<Result<void>> updateDescripition(
      {required String description, required String id});
  Future<Result<ClubModel>> updateClub({required ClubModel club});
}
