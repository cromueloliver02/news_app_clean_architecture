part of 'local_articles_bloc.dart';

sealed class LocalArticlesEvent extends Equatable {
  const LocalArticlesEvent();

  @override
  List<Object> get props => [];
}

final class LocalArticlesLoaded extends LocalArticlesEvent {}

final class LocalArticlesSaved extends LocalArticlesEvent {
  final Article article;

  const LocalArticlesSaved({
    required this.article,
  });

  @override
  List<Object> get props => [article];
}

final class LocalArticlesRemoved extends LocalArticlesEvent {
  final Article article;

  const LocalArticlesRemoved({
    required this.article,
  });

  @override
  List<Object> get props => [article];
}
