part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesEvent {
  const FavoritesEvent();
}

final class FavoriteSaveEvent extends FavoritesEvent {
  final String id;
  // final String sourceId;
  // final String sourceName;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  const FavoriteSaveEvent({
    required this.id,
    // required this.sourceId,
    // required this.sourceName,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });
}

final class FavoriteDeleteEvent extends FavoritesEvent {
  final String favoriteId;

  const FavoriteDeleteEvent({
    required this.favoriteId,
  });
}

final class FavoritesFetchEvent extends FavoritesEvent {
  const FavoritesFetchEvent();
}
