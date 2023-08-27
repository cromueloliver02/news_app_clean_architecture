part of 'articles_bloc.dart';

sealed class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object> get props => [];
}

final class ArticlesLoading extends ArticlesState {}

final class ArticlesSuccess extends ArticlesState {
  final List<Article> articles;

  const ArticlesSuccess({required this.articles});

  @override
  List<Object> get props => [articles];
}

final class ArticlesFailure extends ArticlesState {
  final Failure error;

  const ArticlesFailure({required this.error});

  @override
  List<Object> get props => [error];
}
