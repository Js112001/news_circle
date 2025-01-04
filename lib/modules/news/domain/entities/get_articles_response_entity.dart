import 'package:news_circle/modules/news/domain/entities/article_entity.dart';

class GetArticlesResponseEntity {
  final String status;
  final int totalResults;
  final List<ArticleEntity> articles;

  GetArticlesResponseEntity({
    required this.status,
    required this.totalResults,
    required this.articles,
  });
}
