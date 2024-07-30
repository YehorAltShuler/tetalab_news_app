import 'package:fpdart/fpdart.dart';
import 'package:tetalab_test_task/features/news/domain/repository/articles_repository.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';

class DeleteFavorite implements UseCase<void, String> {
  final ArticlesRepository _articlesRepository;

  DeleteFavorite(this._articlesRepository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await _articlesRepository.deleteArticle(id: params);
  }
}
