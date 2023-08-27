part of 'remote_articles_bloc.dart';

sealed class RemoteArticlesState extends Equatable {
  const RemoteArticlesState();

  @override
  List<Object> get props => [];
}

final class RemoteArticlesLoading extends RemoteArticlesState {}

final class RemoteArticlesSuccess extends RemoteArticlesState {
  final List<Article> articles;

  const RemoteArticlesSuccess({required this.articles});

  @override
  List<Object> get props => [articles];
}

final class RemoteArticlesFailure extends RemoteArticlesState {
  final Failure error;

  const RemoteArticlesFailure({required this.error});

  @override
  List<Object> get props => [error];
}
