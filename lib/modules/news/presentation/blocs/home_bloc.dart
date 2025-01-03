import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_circle/modules/news/domain/entities/article_entity.dart';
import 'package:news_circle/modules/news/domain/entities/article_request_entity.dart';
import 'package:news_circle/modules/news/domain/usecases/get_articles.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetArticlesUseCase _getArticlesUseCase;

  HomeBloc(this._getArticlesUseCase) : super(InitialState()) {
    on<InitialEvent>(_onInitialEvent);
    on<GetArticleEvent>(_onGetArticlesEvent);
  }

  void _onInitialEvent(InitialEvent event, Emitter<HomeState> emit) async {
    emit(InitialState());
  }

  void _onGetArticlesEvent(
      GetArticleEvent event, Emitter<HomeState> emit) async {
    if (event.page == 1) {
      emit(LoadingState());
    } else {
      emit(GetArticleSuccessState(articles: [], isPaginated: true));
    }
    final result = await _getArticlesUseCase(
      params: ArticleRequestEntity(
        category: event.category,
        page: event.page,
      ),
    );
    if (result.length == 1 && result.first.status == 'error') {
      emit(GetArticlesFailureState(result.first.message ?? 'Unexpected Error'));
    } else {
      emit(GetArticleSuccessState(articles: result, isPaginated: false));
    }
  }
}
