import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:news_app_clean_architecture/core/failures/failures.dart';
import 'package:news_app_clean_architecture/core/usecases/usecase.dart';
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
        super(LocalArticlesState.initial()) {
    on<LocalArticlesFetched>(_onLocalArticlesFetched);
    on<LocalArticlesSaved>(_onLocalArticlesSaved);
    on<LocalArticlesRemoved>(_onLocalArticlesRemoved);
  }

  void _onLocalArticlesFetched(
    LocalArticlesFetched event,
    Emitter<LocalArticlesState> emit,
  ) async {
    emit(state.copyWith(
      actionType: () => LocalArticlesActionType.fetching,
      status: () => LocalArticlesStatus.loading,
    ));

    final Either<Failure, List<Article>> either =
        await _getSavedArticlesUseCase(NoParams());

    either.fold(
      (Failure error) {
        if (kDebugMode) debugPrint(error.toString());
        emit(state.copyWith(
          error: () => error,
          status: () => LocalArticlesStatus.failure,
        ));
      },
      (List<Article> articles) {
        emit(state.copyWith(
          articles: () => articles,
          status: () => LocalArticlesStatus.success,
        ));
      },
    );
  }

  void _onLocalArticlesSaved(
    LocalArticlesSaved event,
    Emitter<LocalArticlesState> emit,
  ) async {
    emit(state.copyWith(
      actionType: () => LocalArticlesActionType.saving,
      status: () => LocalArticlesStatus.loading,
    ));

    final Either<Failure, void> either =
        await _saveArticleUseCase(event.article);

    either.fold(
      (Failure error) {
        if (kDebugMode) debugPrint(error.toString());
        emit(state.copyWith(
          error: () => error,
          status: () => LocalArticlesStatus.failure,
        ));
      },
      (_) {
        final List<Article> articles = [...state.articles, event.article];

        emit(state.copyWith(
          articles: () => articles,
          status: () => LocalArticlesStatus.success,
        ));
      },
    );
  }

  void _onLocalArticlesRemoved(
    LocalArticlesRemoved event,
    Emitter<LocalArticlesState> emit,
  ) async {
    emit(state.copyWith(
      actionType: () => LocalArticlesActionType.removing,
      status: () => LocalArticlesStatus.loading,
    ));

    final Either<Failure, void> either =
        await _removeArticleUseCase(event.article);

    either.fold(
      (Failure error) {
        if (kDebugMode) debugPrint(error.toString());
        emit(state.copyWith(
          error: () => error,
          status: () => LocalArticlesStatus.failure,
        ));
      },
      (_) {
        final List<Article> articles =
            state.articles.where((d) => d.id != event.article.id).toList();

        emit(state.copyWith(
          articles: () => articles,
          status: () => LocalArticlesStatus.success,
        ));
      },
    );
  }
}
