import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:news_app_clean_architecture/core/failures/failures.dart';
import 'package:news_app_clean_architecture/features/news/domain/entities/entities.dart';
import 'package:news_app_clean_architecture/features/news/domain/usecases/usecases.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final GetArticlesUseCase _getArticlesUseCase;

  ArticlesBloc(this._getArticlesUseCase) : super(ArticlesLoading()) {
    on<ArticlesLoaded>(_onArticlesLoaded);
  }

  void _onArticlesLoaded(
    ArticlesLoaded event,
    Emitter<ArticlesState> emit,
  ) async {
    emit(ArticlesLoading());

    final Either<Failure, List<Article>> either =
        await _getArticlesUseCase(null);

    either.fold(
      (Failure error) {
        if (kDebugMode) debugPrint(error.toString());
        emit(ArticlesFailure(error: error));
      },
      (List<Article> articles) => emit(ArticlesSuccess(articles: articles)),
    );
  }
}
