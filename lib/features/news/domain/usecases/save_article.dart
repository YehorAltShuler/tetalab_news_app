import 'package:fpdart/fpdart.dart';
import 'package:tetalab_test_task/features/news/domain/entities/article.dart';
import 'package:tetalab_test_task/features/news/domain/repository/articles_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';

class SaveFavorite implements UseCase<void, SaveFavoriteParams> {
  final ArticlesRepository _articlesRepository;

  SaveFavorite(this._articlesRepository);

  @override
  Future<Either<Failure, Article>> call(SaveFavoriteParams params) async {
    return await _articlesRepository.saveArticle(
      id: params.id,
      // sourceId: params.sourceId,
      // sourceName: params.sourceName,
      author: params.author,
      title: params.title,
      description: params.description,
      url: params.url,
      urlToImage: params.urlToImage,
      publishedAt: params.publishedAt,
      content: params.content,
    );
  }
}

class SaveFavoriteParams {
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

  SaveFavoriteParams({
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
