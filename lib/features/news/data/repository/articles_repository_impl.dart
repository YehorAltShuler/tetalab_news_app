import 'package:fpdart/fpdart.dart';
import 'package:tetalab_test_task/features/news/data/data_sources/articles_local_data_source.dart';
import 'package:tetalab_test_task/features/news/data/models/article_model.dart';
import 'package:tetalab_test_task/features/news/domain/entities/article.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repository/articles_repository.dart';
import '../data_sources/articles_remote_data_source.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  final ArticlesRemoteDataSource _articlesRemoteDataSource;
  final ArticlesLocalDataSource _articlesLocalDataSource;

  ArticlesRepositoryImpl(
    this._articlesRemoteDataSource,
    this._articlesLocalDataSource,
  );

  @override
  Future<Either<Failure, List<ArticleModel>>> getArticles(String? q) async {
    try {
      final articles = await _articlesRemoteDataSource.fetchArticles(q: q);
      return right(articles.data);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteArticle({required String id}) async {
    try {
      _articlesLocalDataSource.deleteLocalArticle(id);
      return right(null);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Article>> saveArticle({
    required String id,
    // required String sourceId,
    // required String sourceName,
    required String author,
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
    required String content,
  }) async {
    final article = ArticleModel(
      id: id,
      // sourceId: sourceId,
      // sourceName: sourceName,
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
    try {
      _articlesLocalDataSource.saveLocalArticle(article);
      return right(article);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> getFavoriteArticles() async {
    try {
      final articles = _articlesLocalDataSource.loadLocalArticles();
      return right(articles);
    } on Exception catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
