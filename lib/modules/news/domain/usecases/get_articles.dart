import 'package:news_circle/core/usecase/usecase.dart';
import 'package:news_circle/modules/news/domain/entities/article_request_entity.dart';
import 'package:news_circle/modules/news/domain/entities/get_articles_response_entity.dart';
import 'package:news_circle/modules/news/domain/repositories/news_articles_repository.dart';

class GetArticlesUseCase
    extends UseCase<GetArticlesResponseEntity, ArticleRequestEntity?> {
  final NewsArticlesRepository _newsArticlesRepository;

  GetArticlesUseCase(this._newsArticlesRepository);

  @override
  Future<GetArticlesResponseEntity> call({ArticleRequestEntity? params}) async {
    return await _newsArticlesRepository.getArticles(
      category: params?.category,
      page: params?.page,
    );
  }
}
