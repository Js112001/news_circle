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
