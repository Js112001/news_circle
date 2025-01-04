import 'package:news_circle/modules/news/domain/entities/article_entity.dart';
import 'package:news_circle/modules/news/domain/entities/get_articles_response_entity.dart';

abstract class NewsArticlesRepository {
  Future<GetArticlesResponseEntity> getArticles({String? category, int? page});
  Future<List<ArticleEntity>> getSavedArticles();
  Future<int> saveArticle(ArticleEntity article);
  Future<int> removeSavedArticle(int id);
}