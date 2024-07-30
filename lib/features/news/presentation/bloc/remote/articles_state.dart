part of 'articles_bloc.dart';

@immutable
sealed class ArticlesState {
  const ArticlesState();
}

final class ArticlesInitial extends ArticlesState {}

final class ArticlesLoading extends ArticlesState {}

final class ArticlesFailure extends ArticlesState {
  final String error;
  const ArticlesFailure(this.error);
}

final class ArticlesDeleteSuccess extends ArticlesState {}

final class ArticlesSaveSuccess extends ArticlesState {}

final class ArticlesDisplaySuccess extends ArticlesState {
  final List<Article> articles;
  const ArticlesDisplaySuccess(this.articles);
}

final class ArticlesDisplayFavoritesSuccess extends ArticlesState {
  final List<Article> articles;
  const ArticlesDisplayFavoritesSuccess(this.articles);
}
