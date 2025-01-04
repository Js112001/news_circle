part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class InitialEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class GetArticleEvent extends HomeEvent {
  final String? category;
  final int page;

  GetArticleEvent({
    this.category,
    this.page = 1,
  });

  @override
  List<Object?> get props => [category, page];
}

class SaveArticleEvent extends HomeEvent {
  final ArticleEntity article;

  SaveArticleEvent({required this.article});

  @override
  List<Object?> get props => [article];
}

class RemoveSavedArticleEvent extends HomeEvent {
  final ArticleEntity article;

  RemoveSavedArticleEvent({required this.article});

  @override
  List<Object?> get props => [article];
}

class GetSavedArticleEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}
