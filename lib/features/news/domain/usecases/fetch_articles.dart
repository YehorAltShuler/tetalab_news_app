import 'package:fpdart/fpdart.dart';
import 'package:tetalab_test_task/features/news/domain/entities/article.dart';
import 'package:tetalab_test_task/features/news/domain/repository/articles_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';

class FetchArticles implements UseCase<List<Article>, String?> {
  final ArticlesRepository _articlesRepository;

  FetchArticles(this._articlesRepository);
  @override
  Future<Either<Failure, List<Article>>> call(String? params) async {
    return await _articlesRepository.getArticles(params);
  }
}
