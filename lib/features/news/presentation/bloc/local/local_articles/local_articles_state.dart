part of 'local_articles_bloc.dart';

enum LocalArticlesActionType { fetching, saving, removing }

enum LocalArticlesStatus { initial, loading, success, failure }

class LocalArticlesState extends Equatable {
  final List<Article> articles;
  final LocalArticlesActionType actionType;
  final LocalArticlesStatus status;
  final Failure error;

  const LocalArticlesState({
    required this.articles,
    required this.actionType,
    required this.status,
    required this.error,
  });

  factory LocalArticlesState.initial() {
    return const LocalArticlesState(
      articles: <Article>[],
      actionType: LocalArticlesActionType.fetching,
      status: LocalArticlesStatus.initial,
      error: Failure(),
    );
  }

  @override
  List<Object> get props => [articles, actionType, status, error];

  @override
  String toString() {
    return 'LocalArticlesState(articles: $articles, actionType: $actionType, status: $status, error: $error)';
  }

  LocalArticlesState copyWith({
    List<Article> Function()? articles,
    LocalArticlesActionType Function()? actionType,
    LocalArticlesStatus Function()? status,
    Failure Function()? error,
  }) {
    return LocalArticlesState(
      articles: articles != null ? articles() : this.articles,
      actionType: actionType != null ? actionType() : this.actionType,
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
