import 'package:percasi_tasikmalaya/domain/entities/result.dart';
import 'package:percasi_tasikmalaya/domain/repositories/news_repository.dart';
import 'package:percasi_tasikmalaya/domain/usecase/news/add_news/add_news_params.dart';
import 'package:percasi_tasikmalaya/domain/usecase/usecase.dart';

class AddNews implements UseCase<Result<void>, AddNewsParams> {
  final NewsRepository newsRepository;

  AddNews({required this.newsRepository});
  @override
  Future<Result<void>> call(AddNewsParams params) async {
    final data = await newsRepository.addNews(
        title: params.title,
        description: params.description,
        imageFile: params.imageFile);
    if (data.isSuccess) {
      return const Result.success(null);
    } else {
      return Result.failed(data.errorMessage!);
    }
  }
}
