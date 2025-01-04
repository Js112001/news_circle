import 'package:news_circle/core/usecase/usecase.dart';
import 'package:news_circle/modules/news/domain/entities/article_entity.dart';
import 'package:news_circle/modules/news/domain/repositories/news_articles_repository.dart';

class GetSavedArticlesUseCase extends UseCase<List<ArticleEntity>, void> {
  final NewsArticlesRepository _newsArticlesRepository;

  GetSavedArticlesUseCase(this._newsArticlesRepository);

  @override
  Future<List<ArticleEntity>> call({void params}) async {
    return await _newsArticlesRepository.getSavedArticles();
  }

}