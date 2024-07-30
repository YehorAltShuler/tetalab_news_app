import 'package:tetalab_test_task/features/news/domain/entities/article.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';

abstract interface class ArticlesRepository {
  Future<Either<Failure, List<Article>>> getArticles(String? q);

  Future<Either<Failure, List<Article>>> getFavoriteArticles();

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
  });

  Future<Either<Failure, void>> deleteArticle({required String id});
}
