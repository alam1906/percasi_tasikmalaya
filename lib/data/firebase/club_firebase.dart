import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:percasi_tasikmalaya/domain/entities/club_model.dart';

import '../../domain/entities/result.dart';
import '../../domain/repositories/club_repository.dart';

class ClubFirebase implements ClubRepository {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  @override
  Future<Result<List<ClubModel>>> getAllClub() async {
    List<ClubModel> club = [];
    final data = await _firestore.collection('club').get();
    if (data.docs.isNotEmpty) {
      for (var e in data.docs) {
        final result = ClubModel.fromJson(e.data());
        club.add(result);
      }
      return Result.success(club);
    } else {
      return const Result.failed("Gagal mengambil data club");
    }
  }

  @override
  Future<Result<void>> addClub(
      {required String name, required String fullName}) async {
    final data = await _firestore.collection('club').add({
      'name': name,
      'fullName': fullName,
      'hasLeader': false,
      'member': 0,
      'prestasi': 0,
      'imageUrl': null,
      'description': null,
    });
    await data.update({'id': data.id});

    final result = await _firestore.collection('club').doc(data.id).get();
    if (result.exists) {
      return const Result.success(null);
    } else {
      return const Result.failed("Gagal menambahkan club");
    }
  }

  @override
  Future<Result<void>> updateMember(
      {required String id, required bool isLeader}) async {
    await _firestore
        .collection('club')
        .doc(id)
        .update({'member': FieldValue.increment(1), 'hasLeader': isLeader});
    return const Result.success(null);
  }

  @override
  Future<Result<String>> uploadImage({required File imageFile}) async {
    String fileName = basename(imageFile.path);
    final ref = _storage.ref().child('club/$fileName');
    final task = ref.putFile(imageFile);
    final snapshot = await task;
    final downloadUrl = await snapshot.ref.getDownloadURL();

    return Result.success(downloadUrl);
  }

  @override
  Future<Result<void>> updateDescripition(
      {required String description, required String id}) async {
    await _firestore
        .collection('club')
        .doc(id)
        .update({'description': description});
    return const Result.success(null);
  }

  @override
  Future<Result<ClubModel>> updateClub({required ClubModel club}) async {
    try {
      await _firestore.collection('club').doc(club.id).update(club.toJson());
      final result = await _firestore.collection('club').doc(club.id).get();
      if (result.exists) {
        ClubModel updateClub = ClubModel.fromJson(result.data()!);
        if (updateClub == club) {
          return Result.success(updateClub);
        } else {
          return const Result.failed("Gagal mengupdate data");
        }
      } else {
        return const Result.failed("Gagal mengupdate data");
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? 'Gagal mengupdate data');
    }
  }
}
