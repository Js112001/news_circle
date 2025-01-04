import 'package:news_circle/modules/news/data/models/article_response_model.dart';
import 'package:news_circle/modules/news/domain/entities/get_articles_response_entity.dart';

class GetArticlesResponseModel extends GetArticlesResponseEntity {
  final String status;
  final int totalResults;
  final List<ArticleResponseModel> articles;

  GetArticlesResponseModel({
    required this.status,
    required this.totalResults,
    required this.articles,
  }) : super(
          status: status,
          totalResults: totalResults,
          articles: articles,
        );

  factory GetArticlesResponseModel.fromJson(Map<String, dynamic> json) =>
      GetArticlesResponseModel(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: (json["articles"] as List<dynamic>)
            .map(
              (e) => ArticleResponseModel.fromJson(e),
            )
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResult": totalResults,
        "articles": articles,
      };
}
