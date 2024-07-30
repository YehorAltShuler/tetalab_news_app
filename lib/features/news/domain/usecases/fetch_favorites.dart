import 'package:fpdart/fpdart.dart';
import 'package:tetalab_test_task/features/news/domain/entities/article.dart';
import 'package:tetalab_test_task/features/news/domain/repository/articles_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';

class FetchFavorites implements UseCase<List<Article>, NoParams> {
  final ArticlesRepository _articlesRepository;

  FetchFavorites(this._articlesRepository);
  @override
  Future<Either<Failure, List<Article>>> call(NoParams params) async {
    return await _articlesRepository.getFavoriteArticles();
  }
}
