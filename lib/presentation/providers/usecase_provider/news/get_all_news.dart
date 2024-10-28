import 'package:percasi_tasikmalaya/domain/usecase/news/get_all_news/get_all_news.dart';
import 'package:percasi_tasikmalaya/presentation/providers/repositories_provider/news_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_all_news.g.dart';

@riverpod
GetAllNews getAllNews(GetAllNewsRef ref) =>
    GetAllNews(newsRepository: ref.read(newsRepositoryProvider));
