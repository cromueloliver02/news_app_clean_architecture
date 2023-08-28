import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:news_app_clean_architecture/core/failures/failures.dart';
import 'package:news_app_clean_architecture/core/usecases/usecase.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/usecases.dart';

part 'remote_articles_event.dart';
part 'remote_articles_state.dart';

class RemoteArticlesBloc
    extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticlesUseCase _getArticlesUseCase;

  RemoteArticlesBloc({
    required GetArticlesUseCase getArticlesUseCase,
  })  : _getArticlesUseCase = getArticlesUseCase,
        super(RemoteArticlesState.initial()) {
    on<RemoteArticlesFetched>(_onArticlesFetched);
  }

  void _onArticlesFetched(
    RemoteArticlesFetched event,
    Emitter<RemoteArticlesState> emit,
  ) async {
    emit(state.copyWith(status: () => RemoteArticlesStatus.loading));

    final Either<Failure, List<Article>> either =
        await _getArticlesUseCase(NoParams());

    either.fold(
      (Failure error) {
        if (kDebugMode) debugPrint(error.toString());
        emit(state.copyWith(
          error: () => error,
          status: () => RemoteArticlesStatus.failure,
        ));
      },
      (List<Article> articles) {
        emit(state.copyWith(
          articles: () => articles,
          status: () => RemoteArticlesStatus.success,
        ));
      },
    );
  }
}
