import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:percasi_tasikmalaya/domain/entities/news_model.dart';
import 'package:percasi_tasikmalaya/domain/usecase/news/add_news/add_news_params.dart';
import 'package:percasi_tasikmalaya/presentation/providers/usecase_provider/news/add_news_provider.dart';
import 'package:percasi_tasikmalaya/presentation/providers/usecase_provider/news/get_all_news.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'news_data_provider.g.dart';

@Riverpod(keepAlive: true)
class NewsData extends _$NewsData {
  @override
  Future<List<NewsModel>?> build() async {
    final data = ref.read(getAllNewsProvider);
    final result = await data(null);
    if (result.isSuccess) {
      return result.resultValue!;
    } else {
      return null;
    }
  }

  List<NewsModel>? getNewsLimit() {
    final data = state.valueOrNull;
    final result = data?.sublist(0, 4);
    if (result != null) {
      return result;
    } else {
      return null;
    }
  }

  Future<void> refreshData() async {
    final data = ref.read(getAllNewsProvider);
    final result = await data(null);
    if (result.isSuccess) {
      state = AsyncData(result.resultValue);
    } else {
      state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> addNews(
      {required String title,
      required String description,
      required File imageFile}) async {
    state = const AsyncLoading();
    final data = ref.read(addNewsProvider);
    final result = await data(AddNewsParams(
        title: title, description: description, imageFile: imageFile));
    if (result.isSuccess) {
      refreshData();
    } else {
      state =
          AsyncError(FlutterError(result.errorMessage!), StackTrace.current);
      state = AsyncData(state.valueOrNull);
    }
  }
}
