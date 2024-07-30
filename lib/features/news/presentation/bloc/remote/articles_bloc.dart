import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetalab_test_task/features/news/domain/usecases/fetch_articles.dart';

import '../../../domain/entities/article.dart';

part 'articles_event.dart';
part 'articles_state.dart';

class ArticlesBloc extends Bloc<ArticlesEvent, ArticlesState> {
  final FetchArticles _fetchArticles;

  ArticlesBloc({
    required FetchArticles fetchArticles,
  })  : _fetchArticles = fetchArticles,
        super(ArticlesInitial()) {
    on<ArticlesEvent>((event, emit) => emit(ArticlesLoading()));

    on<ArticlesFetchEvent>(_onFetchArticles);
  }

  void _onFetchArticles(
    ArticlesFetchEvent event,
    Emitter<ArticlesState> emit,
  ) async {
    final response = await _fetchArticles(event.q);

    response.fold(
      (failure) => emit(ArticlesFailure(failure.message)),
      (articles) => emit(ArticlesDisplaySuccess(articles)),
    );
  }
}
