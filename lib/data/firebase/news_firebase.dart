import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:percasi_tasikmalaya/domain/entities/news_model.dart';
import 'package:percasi_tasikmalaya/domain/entities/result.dart';
import 'package:percasi_tasikmalaya/domain/repositories/news_repository.dart';

class NewsFirebase implements NewsRepository {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;
  @override
  Future<Result<void>> addNews(
      {required String title,
      required String description,
      required File imageFile}) async {
    String date = DateFormat('dd-MMMM-yyyy')
        .format(DateTime.now())
        .toString()
        .replaceAll('-', ' ');
    String fileName = basename(imageFile.path);
    final ref = _storage.ref().child('news/$fileName');
    final task = ref.putFile(imageFile);
    final snapshot = await task;
    final url = await snapshot.ref.getDownloadURL();

    final data = await _firestore.collection('news').add({
      'title': title,
      'description': description,
      'imageUrl': url,
      'date': date,
      'dateTime': date,
    });
    await data.update({'id': data.id});

    final result = await _firestore.collection('news').doc(data.id).get();
    if (result.exists) {
      return const Result.success(null);
    } else {
      return const Result.failed("Gagal menambahkan news");
    }
  }

  @override
  Future<Result<List<NewsModel>>> getAllNews() async {
    final data = await _firestore.collection('news').get();
    if (data.docs.isNotEmpty) {
      List<NewsModel> result = [];
      for (var e in data.docs) {
        final hasil = NewsModel.fromJson(e.data());
        result.add(hasil);
      }
      return Result.success(result);
    } else {
      return const Result.failed("Gagal mengambil data");
    }
  }
}
