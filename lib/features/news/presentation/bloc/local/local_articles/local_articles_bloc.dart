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

  LocalArticlesBloc({
    required GetSavedArticlesUseCase getSavedArticlesUseCase,
  })  : _getSavedArticlesUseCase = getSavedArticlesUseCase,
        super(LocalArticlesInitial()) {
    on<LocalArticlesLoaded>(_onLocalArticlesLoaded);
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
      (List<Article> articles) => emit(
        LocalArticlesSuccess(articles: articles),
      ),
    );
  }
}
