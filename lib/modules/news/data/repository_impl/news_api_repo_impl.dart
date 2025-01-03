import 'package:news_circle/modules/news/data/data_sources/remote/news_api_service.dart';
import 'package:news_circle/modules/news/domain/entities/article_entity.dart';
import 'package:news_circle/modules/news/domain/repositories/news_api_repository.dart';

class NewsApiRepoImpl extends NewsApiRepository {
  final NewsApiService _newsApiService;

  NewsApiRepoImpl(this._newsApiService);

  @override
  Future<List<ArticleEntity>> getArticles({
    String? category,
    int? page,
  }) async {
    final responseModel = await _newsApiService.getArticles(
      category: category,
      page: page,
    );

    return responseModel
        .map(
          (e) => e.toEntity(),
        )
        .toList();
  }
}
