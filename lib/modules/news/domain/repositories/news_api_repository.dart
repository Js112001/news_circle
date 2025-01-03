import 'package:news_circle/modules/news/domain/entities/article_entity.dart';

abstract class NewsApiRepository {
  Future<List<ArticleEntity>> getArticles({String? category, int? page});
}