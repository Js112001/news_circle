import 'package:news_circle/core/usecase/usecase.dart';
import 'package:news_circle/modules/news/domain/entities/article_entity.dart';
import 'package:news_circle/modules/news/domain/repositories/news_articles_repository.dart';

class SaveArticleUseCase extends UseCase<int, ArticleEntity?> {
  final NewsArticlesRepository _newsArticlesRepository;

  SaveArticleUseCase(this._newsArticlesRepository);

  @override
  Future<int> call({ArticleEntity? params}) async {
    return await _newsArticlesRepository.saveArticle(params!);
  }
}
