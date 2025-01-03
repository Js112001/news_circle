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
