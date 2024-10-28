import 'dart:io';

import 'package:percasi_tasikmalaya/domain/entities/news_model.dart';

import '../entities/result.dart';

abstract interface class NewsRepository {
  Future<Result<List<NewsModel>>> getAllNews();
  Future<Result<void>> addNews({
    required String title,
    required String description,
    required File imageFile,
  });
}
