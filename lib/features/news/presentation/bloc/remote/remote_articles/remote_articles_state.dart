part of 'remote_articles_bloc.dart';

enum RemoteArticlesStatus { initial, loading, success, failure }

class RemoteArticlesState extends Equatable {
  final List<Article> articles;
  final RemoteArticlesStatus status;
  final Failure error;

  const RemoteArticlesState({
    required this.articles,
    required this.status,
    required this.error,
  });

  factory RemoteArticlesState.initial() {
    return const RemoteArticlesState(
      articles: <Article>[],
      status: RemoteArticlesStatus.initial,
      error: Failure(),
    );
  }

  @override
  String toString() =>
      'RemoteArticlesState(articles: $articles, status: $status, error: $error)';

  @override
  List<Object> get props => [articles, status, error];

  RemoteArticlesState copyWith({
    List<Article> Function()? articles,
    RemoteArticlesStatus Function()? status,
    Failure Function()? error,
  }) {
    return RemoteArticlesState(
      articles: articles != null ? articles() : this.articles,
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }
}
