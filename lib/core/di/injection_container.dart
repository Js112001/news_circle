import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_circle/modules/news/data/data_sources/remote/news_api_service.dart';
import 'package:news_circle/modules/news/data/repository_impl/news_api_repo_impl.dart';
import 'package:news_circle/modules/news/domain/repositories/news_api_repository.dart';
import 'package:news_circle/modules/news/domain/usecases/get_articles.dart';
import 'package:news_circle/modules/news/presentation/blocs/home_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // dio
  sl.registerSingleton<Dio>(Dio());

  // dependencies
  sl.registerSingleton<NewsApiService>(NewsApiServiceImpl(sl()));
  sl.registerSingleton<NewsApiRepository>(NewsApiRepoImpl(sl()));

  // usecases
  sl.registerSingleton<GetArticlesUseCase>(GetArticlesUseCase(sl()));

  // blocs
  sl.registerFactory<HomeBloc>(() => HomeBloc(sl()));
}
