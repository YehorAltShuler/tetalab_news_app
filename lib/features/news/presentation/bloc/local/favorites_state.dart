part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesState {
  const FavoritesState();
}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesFailure extends FavoritesState {
  final String error;
  const FavoritesFailure(this.error);
}

final class FavoriteDeleteSuccess extends FavoritesState {}

final class FavoriteSaveSuccess extends FavoritesState {}

final class FavoritesDisplaySuccess extends FavoritesState {
  final List<Article> favorites;
  const FavoritesDisplaySuccess(this.favorites);
}
