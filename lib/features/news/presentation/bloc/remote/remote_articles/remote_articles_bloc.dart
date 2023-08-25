import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:news_app_clean_architecture/core/failures/failures.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/usecases.dart';

part 'remote_articles_event.dart';
part 'remote_articles_state.dart';

class RemoteArticlesBloc
    extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticlesUseCase _getArticlesUseCase;

  RemoteArticlesBloc(this._getArticlesUseCase)
      : super(RemoteArticlesLoading()) {
    on<ArticlesFetched>(_onArticlesFetched);
  }

  void _onArticlesFetched(
    ArticlesFetched event,
    Emitter<RemoteArticlesState> emit,
  ) async {
    emit(RemoteArticlesLoading());

    final Either<Failure, List<Article>> either =
        await _getArticlesUseCase(null);

    either.fold(
      (Failure error) => emit(RemoteArticlesFailure(error: error)),
      (List<Article> articles) => emit(
        RemoteArticlesSuccess(articles: articles),
      ),
    );
  }
}
