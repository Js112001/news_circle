import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_circle/modules/news/domain/entities/article_entity.dart';
import 'package:news_circle/modules/news/domain/entities/article_request_entity.dart';
import 'package:news_circle/modules/news/domain/usecases/get_articles.dart';
import 'package:news_circle/modules/news/domain/usecases/get_saved_articles.dart';
import 'package:news_circle/modules/news/domain/usecases/remove_saved_article.dart';
import 'package:news_circle/modules/news/domain/usecases/save_article.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetArticlesUseCase _getArticlesUseCase;
  final GetSavedArticlesUseCase _getSavedArticlesUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveSavedArticleUseCase _removeSavedArticleUseCase;

  HomeBloc(
    this._getArticlesUseCase,
    this._getSavedArticlesUseCase,
    this._saveArticleUseCase,
    this._removeSavedArticleUseCase,
  ) : super(InitialState()) {
    on<InitialEvent>(_onInitialEvent);
    on<GetArticleEvent>(_onGetArticlesEvent);
    on<GetSavedArticleEvent>(_onGetSavedArticleEvent);
    on<RemoveSavedArticleEvent>(_onRemoveSavedArticleEvent);
    on<SaveArticleEvent>(_onSaveArticleEvent);
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
    try {
      final result = await _getArticlesUseCase(
        params: ArticleRequestEntity(
          category: event.category,
          page: event.page,
        ),
      );

      var allArticles = result.articles;
      final savedArticles = await _getSavedArticlesUseCase();

      for (var savedArticle in savedArticles) {
        var index = allArticles.indexOf(savedArticle);
        if (index >= 0) {
          allArticles[index].copyWith(id: savedArticle.id);
        }
      }

      emit(GetArticleSuccessState(
        articles: allArticles,
        isPaginated: false,
      ));
    } catch (e) {
      emit(GetArticlesFailureState(e.toString()));
    }
  }

  void _onGetSavedArticleEvent(
      GetSavedArticleEvent event, Emitter<HomeState> emit) async {
    // final result = await _getSavedArticlesUseCase();
    // emit()
  }

  void _onRemoveSavedArticleEvent(
      RemoveSavedArticleEvent event, Emitter<HomeState> emit) async {
    final result = await _removeSavedArticleUseCase(params: event.article.id);
    if (result >= 1) {
      emit(SavedArticleSuccessState('Article removed from save'));
    } else {
      emit(SavedArticleFailureState('Failed to remove article from save'));
    }
  }

  void _onSaveArticleEvent(
      SaveArticleEvent event, Emitter<HomeState> emit) async {
    final result = await _saveArticleUseCase(params: event.article);
    if (result >= 1) {
      emit(SavedArticleSuccessState('Article added to save'));
    } else {
      emit(SavedArticleFailureState('Failed to add article to save'));
    }
  }
}
