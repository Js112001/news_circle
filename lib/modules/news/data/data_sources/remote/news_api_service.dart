import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_circle/modules/news/data/models/article_response_model.dart';
import 'package:news_circle/utils/app_logger.dart';
import 'package:news_circle/utils/constants.dart';

abstract class NewsApiService {
  Future<List<ArticleResponseModel>> getArticles({
    String? category,
    int? page,
  });
}

class NewsApiServiceImpl extends NewsApiService {
  final Dio _dio;

  NewsApiServiceImpl(this._dio);

  @override
  Future<List<ArticleResponseModel>> getArticles({
    String? category,
    int? page,
  }) async {
    try {
      var queryParameters = {
        "country": "us",
        "apiKey": "${dotenv.env['NEWS_API_KEY']}",
        "pageSize": 10,
        "page": '$page',
      };

      if (category != null && category != 'all') {
        queryParameters.addAll({"category": category});
      }
      var response = await _dio.request(
        '${StringConstants.baseNewsApiUrl}/top-headlines',
        options: Options(
          method: 'GET',
        ),
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        final result = response.data['articles'] as List<dynamic>?;
        return result
                ?.map(
                  (e) => ArticleResponseModel.fromJson(e),
                )
                .toList() ??
            [];
      } else {
        AppLogger.e(response.statusMessage);
        final result = response.data;
        return [
          ArticleResponseModel.fromJson(
            {
              "status": result["status"],
              "code": result["code"],
              "message": result["message"],
            },
          ),
        ];
      }
    } catch (e) {
      AppLogger.e(e);
      return [
        ArticleResponseModel.fromJson(
          {
            "status": "error",
            "code": "Unknown",
            "message": "Exception while getting articles",
          },
        ),
      ];
    }
  }
}
