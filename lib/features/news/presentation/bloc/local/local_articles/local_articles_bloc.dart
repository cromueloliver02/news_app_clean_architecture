import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:news_app_clean_architecture/core/failures/failures.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/usecases.dart';

part 'local_articles_event.dart';
part 'local_articles_state.dart';

class LocalArticlesBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticlesUseCase _getSavedArticlesUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticlesBloc({
    required GetSavedArticlesUseCase getSavedArticlesUseCase,
    required SaveArticleUseCase saveArticleUseCase,
    required RemoveArticleUseCase removeArticleUseCase,
  })  : _getSavedArticlesUseCase = getSavedArticlesUseCase,
        _saveArticleUseCase = saveArticleUseCase,
        _removeArticleUseCase = removeArticleUseCase,
        super(LocalArticlesInitial()) {
    on<LocalArticlesLoaded>(_onLocalArticlesLoaded);
    on<LocalArticlesSaved>(_onLocalArticlesSaved);
    on<LocalArticlesRemoved>(_onLocalArticlesRemoved);
  }

  void _onLocalArticlesLoaded(
    LocalArticlesLoaded event,
    Emitter<LocalArticlesState> emit,
  ) async {
    emit(LocalArticlesLoading());

    final Either<Failure, List<Article>> either =
        await _getSavedArticlesUseCase(null);

    either.fold(
      (Failure error) {
        if (kDebugMode) debugPrint(error.toString());
        emit(LocalArticlesFailure(error: error));
      },
      (List<Article> articles) {
        emit(LocalArticlesSuccess(articles: articles));
      },
    );
  }

  void _onLocalArticlesSaved(
    LocalArticlesSaved event,
    Emitter<LocalArticlesState> emit,
  ) async {
    emit(LocalArticlesSaving());

    final Either<Failure, void> either =
        await _saveArticleUseCase(event.article);

    either.fold(
      (Failure error) {
        if (kDebugMode) debugPrint(error.toString());
        emit(LocalArticlesFailure(error: error));
      },
      (_) {
        final List<Article> articles = [
          ...(state as LocalArticlesSuccess).articles,
          event.article,
        ];
        emit(LocalArticlesSuccess(articles: articles));
      },
    );
  }

  void _onLocalArticlesRemoved(
    LocalArticlesRemoved event,
    Emitter<LocalArticlesState> emit,
  ) async {
    emit(LocalArticlesRemoving());

    final Either<Failure, void> either =
        await _removeArticleUseCase(event.article);

    either.fold(
      (Failure error) {
        if (kDebugMode) debugPrint(error.toString());
        emit(LocalArticlesFailure(error: error));
      },
      (_) {
        final List<Article> articles = (state as LocalArticlesSuccess)
            .articles
            .where((d) => d.id != event.article.id)
            .toList();

        emit(LocalArticlesSuccess(articles: articles));
      },
    );
  }
}
