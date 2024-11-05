import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percasi_tasikmalaya/domain/usecase/news/add_news/add_news.dart';
import 'package:percasi_tasikmalaya/presentation/providers/repositories_provider/news_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'add_news_provider.g.dart';

@riverpod
AddNews addNews(Ref ref) =>
    AddNews(newsRepository: ref.read(newsRepositoryProvider));
