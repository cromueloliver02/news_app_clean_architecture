part of 'local_articles_bloc.dart';

sealed class LocalArticlesEvent extends Equatable {
  const LocalArticlesEvent();

  @override
  List<Object> get props => [];
}

final class LocalArticlesLoaded extends LocalArticlesEvent {}
