import 'package:news_circle/modules/news/data/data_sources/local/news_db_service.dart';
import 'package:news_circle/modules/news/data/data_sources/remote/news_api_service.dart';
import 'package:news_circle/modules/news/data/models/article_response_model.dart';
import 'package:news_circle/modules/news/domain/entities/article_entity.dart';
import 'package:news_circle/modules/news/domain/entities/get_articles_response_entity.dart';
import 'package:news_circle/modules/news/domain/repositories/news_articles_repository.dart';

class NewsArticlesRepoImpl extends NewsArticlesRepository {
  final NewsApiService _newsApiService;
  final NewsDbService _newsDbService;

  NewsArticlesRepoImpl(this._newsApiService, this._newsDbService);

  @override
  Future<GetArticlesResponseEntity> getArticles({
    String? category,
    int? page,
  }) async {
    final responseModel = await _newsApiService.getArticles(
      category: category,
      page: page,
    );

    return responseModel;
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() async {
    return await _newsDbService.getSavedArticles();
  }

  @override
  Future<int> removeSavedArticle(int id)  async {
    return await _newsDbService.removeSavedArticle(id);
  }

  @override
  Future<int> saveArticle(ArticleEntity article) async {
    final articleModel = ArticleResponseModel.fromJson(article.toJson());
    return await _newsDbService.saveArticle(articleModel);
  }
}
