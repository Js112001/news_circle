part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class InitialState extends HomeState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class GetArticleSuccessState extends HomeState {
  final List<ArticleEntity> articles;
  final bool isPaginated;

  GetArticleSuccessState({required this.articles, this.isPaginated = false});

  @override
  List<Object?> get props => [articles, isPaginated];
}

class GetArticlesFailureState extends HomeState {
  final String message;

  GetArticlesFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class SavedArticleSuccessState extends HomeState {
  final String message;

  SavedArticleSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class SavedArticleFailureState extends HomeState {
  final String message;

  SavedArticleFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
