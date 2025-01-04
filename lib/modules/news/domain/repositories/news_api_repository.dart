import 'package:news_circle/modules/news/domain/entities/get_articles_response_entity.dart';

abstract class NewsApiRepository {
  Future<GetArticlesResponseEntity> getArticles({String? category, int? page});
}