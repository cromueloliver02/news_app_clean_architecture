part of 'remote_articles_bloc.dart';

sealed class RemoteArticlesEvent extends Equatable {
  const RemoteArticlesEvent();

  @override
  List<Object> get props => [];
}

final class RemoteArticlesLoaded extends RemoteArticlesEvent {}
