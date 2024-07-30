import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetalab_test_task/core/usecase/usecase.dart';
import 'package:tetalab_test_task/features/news/domain/usecases/fetch_favorites.dart';

import '../../../domain/entities/article.dart';
import '../../../domain/usecases/delete_article.dart';
import '../../../domain/usecases/save_article.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final SaveFavorite _saveFavorite;

  final DeleteFavorite _deleteFavorite;
  final FetchFavorites _fetchFavorites;
  FavoritesBloc({
    required SaveFavorite saveFavorite,
    required DeleteFavorite deleteFavorite,
    required FetchFavorites fetchFavorites,
  })  : _saveFavorite = saveFavorite,
        _deleteFavorite = deleteFavorite,
        _fetchFavorites = fetchFavorites,
        super(FavoritesInitial()) {
    on<FavoritesEvent>((event, emit) => emit(FavoritesLoading()));
    on<FavoriteSaveEvent>(_onFavoriteSave);
    on<FavoriteDeleteEvent>(_onFavoriteDelete);
    on<FavoritesFetchEvent>(_onFetchFavorites);
  }

  void _onFavoriteDelete(
    FavoriteDeleteEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final response = await _deleteFavorite(event.favoriteId);

    response.fold((failure) => emit(FavoritesFailure(failure.message)),
        (success) {
      emit(FavoriteDeleteSuccess());
      add(const FavoritesFetchEvent());
    });
  }

  void _onFavoriteSave(
    FavoriteSaveEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final response = await _saveFavorite(
      SaveFavoriteParams(
        id: event.id,
        // sourceId: event.sourceId,
        // sourceName: event.sourceName,
        author: event.author,
        title: event.title,
        description: event.description,
        url: event.url,
        urlToImage: event.urlToImage,
        publishedAt: event.publishedAt,
        content: event.content,
      ),
    );

    response.fold((failure) => emit(FavoritesFailure(failure.message)),
        (success) {
      emit(FavoriteSaveSuccess());
      add(const FavoritesFetchEvent());
    });
  }

  void _onFetchFavorites(
    FavoritesFetchEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final response = await _fetchFavorites(NoParams());

    response.fold(
      (failure) => emit(FavoritesFailure(failure.message)),
      (favorites) => emit(FavoritesDisplaySuccess(favorites)),
    );
  }
}
