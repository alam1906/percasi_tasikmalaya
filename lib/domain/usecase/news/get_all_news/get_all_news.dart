import 'package:percasi_tasikmalaya/domain/entities/news_model.dart';
import 'package:percasi_tasikmalaya/domain/entities/result.dart';
import 'package:percasi_tasikmalaya/domain/repositories/news_repository.dart';
import 'package:percasi_tasikmalaya/domain/usecase/usecase.dart';

class GetAllNews implements UseCase<Result<List<NewsModel>>, void> {
  final NewsRepository newsRepository;

  GetAllNews({required this.newsRepository});
  @override
  Future<Result<List<NewsModel>>> call(void params) async {
    final data = await newsRepository.getAllNews();
    if (data.isSuccess) {
      return Result.success(data.resultValue!);
    } else {
      return Result.failed(data.errorMessage!);
    }
  }
}
