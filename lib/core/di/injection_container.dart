import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_circle/core/database/database_helper.dart';
import 'package:news_circle/core/network/base_network.dart';
import 'package:news_circle/modules/news/data/data_sources/local/news_db_service.dart';
import 'package:news_circle/modules/news/data/data_sources/remote/news_api_service.dart';
import 'package:news_circle/modules/news/data/repository_impl/news_articles_repo_impl.dart';
import 'package:news_circle/modules/news/domain/repositories/news_articles_repository.dart';
import 'package:news_circle/modules/news/domain/usecases/get_articles.dart';
import 'package:news_circle/modules/news/domain/usecases/get_saved_articles.dart';
import 'package:news_circle/modules/news/domain/usecases/remove_saved_article.dart';
import 'package:news_circle/modules/news/domain/usecases/save_article.dart';
import 'package:news_circle/modules/news/presentation/blocs/home_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // dio
  sl.registerSingleton<Dio>(Dio());

  // network
  sl.registerFactory<BaseNetwork>(
    () => BaseNetwork(sl()),
  );

  // db
  sl.registerSingleton(DatabaseHelper());
  sl.registerFactory<NewsDbService>(
    () => NewsDbServiceImpl(sl()),
  );

  // dependencies
  sl.registerSingleton<NewsApiService>(NewsApiServiceImpl(sl()));
  sl.registerSingleton<NewsArticlesRepository>(NewsArticlesRepoImpl(sl(), sl()));

  // usecases
  sl.registerSingleton<GetArticlesUseCase>(GetArticlesUseCase(sl()));
  sl.registerSingleton<GetSavedArticlesUseCase>(GetSavedArticlesUseCase(sl()));
  sl.registerSingleton<RemoveSavedArticleUseCase>(RemoveSavedArticleUseCase(sl()));
  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));

  // blocs
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl(), sl(), sl(), sl()));
}
