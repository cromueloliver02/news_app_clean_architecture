part of 'local_articles_bloc.dart';

sealed class LocalArticlesState extends Equatable {
  const LocalArticlesState();

  @override
  List<Object> get props => [];
}

final class LocalArticlesInitial extends LocalArticlesState {}

final class LocalArticlesLoading extends LocalArticlesState {}

final class LocalArticlesSaving extends LocalArticlesState {}

final class LocalArticlesRemoving extends LocalArticlesState {}

final class LocalArticlesSuccess extends LocalArticlesState {
  final List<Article> articles;

  const LocalArticlesSuccess({
    required this.articles,
  });

  @override
  List<Object> get props => [articles];
}

final class LocalArticlesFailure extends LocalArticlesState {
  final Failure error;

  const LocalArticlesFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
