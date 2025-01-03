import 'package:news_circle/core/usecase/usecase.dart';
import 'package:news_circle/modules/news/domain/entities/article_entity.dart';
import 'package:news_circle/modules/news/domain/entities/article_request_entity.dart';
import 'package:news_circle/modules/news/domain/repositories/news_api_repository.dart';

class GetArticlesUseCase
    extends UseCase<List<ArticleEntity>, ArticleRequestEntity?> {
  final NewsApiRepository _newsApiRepository;

  GetArticlesUseCase(this._newsApiRepository);

  @override
  Future<List<ArticleEntity>> call({ArticleRequestEntity? params}) async {
    return await _newsApiRepository.getArticles(
      category: params?.category,
      page: params?.page,
    );
  }
}