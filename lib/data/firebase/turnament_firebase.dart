import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:percasi_tasikmalaya/domain/entities/result.dart';
import 'package:percasi_tasikmalaya/domain/entities/turnament_model.dart';
import 'package:percasi_tasikmalaya/domain/repositories/turnament_repository.dart';

class TurnamentFirebase implements TurnamentRepository {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  @override
  Future<Result<void>> addTurnament(
      {required String title, required File imageFile}) async {
    String date = DateFormat('dd-MMMM-yyyy')
        .format(DateTime.now())
        .toString()
        .replaceAll('-', ' ');
    String fileName = basename(imageFile.path);
    final ref = _storage.ref().child('turnament/$fileName');
    final task = ref.putFile(imageFile);
    final snapshot = await task;
    final url = await snapshot.ref.getDownloadURL();

    final data = await _firestore.collection('turnament').add({
      "title": title,
      "imageUrl": url,
      "date": date,
    });

    await _firestore
        .collection('turnament')
        .doc(data.id)
        .update({"id": data.id});
    final result = await _firestore.collection('turnament').doc(data.id).get();
    if (result.exists) {
      return const Result.success(null);
    } else {
      return const Result.failed("Gagal menambahkan turnament");
    }
  }

  @override
  Future<Result<List<TurnamentModel>>> getTurnament() async {
    final data = await _firestore.collection('turnament').get();
    if (data.docs.isNotEmpty) {
      List<TurnamentModel> result = [];
      for (var e in data.docs) {
        final hasil = TurnamentModel.fromJson(e.data());
        result.add(hasil);
      }
      return Result.success(result);
    } else {
      return const Result.failed("Tidak ada data");
    }
  }
}
