import 'package:news_circle/core/database/database_helper.dart';
import 'package:news_circle/modules/news/data/models/article_response_model.dart';
import 'package:news_circle/utils/app_logger.dart';

abstract class NewsDbService {
  Future<List<ArticleResponseModel>> getSavedArticles();

  Future<int> saveArticle(ArticleResponseModel article);

  Future<int> removeSavedArticle(int id);
}

class NewsDbServiceImpl extends NewsDbService {
  final DatabaseHelper databaseHelper;

  NewsDbServiceImpl(this.databaseHelper);

  @override
  Future<List<ArticleResponseModel>> getSavedArticles() async {
    final articles =
        await databaseHelper.getSavedArticles();
    AppLogger.i('[Saved][Articles]: $articles');
    return [];
  }

  @override
  Future<int> removeSavedArticle(int id) async {
    return await databaseHelper.removeArticle(id);
  }

  @override
  Future<int> saveArticle(ArticleResponseModel article) async {
    return await databaseHelper.saveArticle(article.toJson());
  }
}
