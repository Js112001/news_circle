import 'package:news_circle/core/usecase/usecase.dart';
import 'package:news_circle/modules/news/domain/repositories/news_articles_repository.dart';

class RemoveSavedArticleUseCase extends UseCase<int, int?> {
  final NewsArticlesRepository _newsArticlesRepository;

  RemoveSavedArticleUseCase(this._newsArticlesRepository);

  @override
  Future<int> call({int? params}) async {
    return await _newsArticlesRepository.removeSavedArticle(params!);
  }
}
