part of 'articles_bloc.dart';

@immutable
sealed class ArticlesEvent {
  const ArticlesEvent();
}

final class ArticlesFetchEvent extends ArticlesEvent {
  final String? q;
  const ArticlesFetchEvent(this.q);
}
