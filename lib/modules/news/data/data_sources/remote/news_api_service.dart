import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_circle/core/network/base_network.dart';
import 'package:news_circle/modules/news/data/models/get_articles_response_model.dart';
import 'package:news_circle/utils/enums.dart';

abstract class NewsApiService {
  Future<GetArticlesResponseModel> getArticles({
    String? category,
    int? page,
  });
}

class NewsApiServiceImpl extends NewsApiService {
  final BaseNetwork _baseNetwork;

  NewsApiServiceImpl(this._baseNetwork);

  @override
  Future<GetArticlesResponseModel> getArticles({
    String? category,
    int? page,
  }) async {
    var queryParameters = {
      "country": "us",
      "apiKey": "${dotenv.env['NEWS_API_KEY']}",
      "pageSize": 10,
      "page": '$page',
    };

    if (category != null && category != 'all') {
      queryParameters.addAll({"category": category});
    }
    final response = await _baseNetwork.sendRequest(
      endpoint: 'top-headlines',
      method: NetworkRequestMethod.get,
      queryParameters: queryParameters, fromJson: (data) =>
        GetArticlesResponseModel.fromJson(data),
    );

    return response;
  }
}
