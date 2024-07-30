import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tetalab_test_task/features/news/data/data_sources/articles_remote_data_source.dart';
import 'package:tetalab_test_task/features/news/domain/usecases/delete_article.dart';
import 'package:tetalab_test_task/features/news/domain/usecases/fetch_articles.dart';
import 'package:tetalab_test_task/features/news/domain/usecases/fetch_favorites.dart';
import 'package:tetalab_test_task/features/news/domain/usecases/save_article.dart';
import 'package:tetalab_test_task/features/news/presentation/bloc/remote/articles_bloc.dart';

import 'features/news/data/data_sources/articles_local_data_source.dart';
import 'features/news/data/repository/articles_repository_impl.dart';
import 'features/news/domain/repository/articles_repository.dart';
import 'features/news/presentation/bloc/local/favorites_bloc.dart';

final sl = GetIt.instance;

Future<void> initializedDependencies() async {
  _initArticles();
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  sl.registerLazySingleton(() => Hive.box(name: 'articles'));
}

void _initArticles() {
  sl

    //Dio
    ..registerSingleton<Dio>(Dio())

    //Data sources
    ..registerFactory<ArticlesRemoteDataSource>(
        () => ArticlesRemoteDataSource(sl()))
    ..registerFactory<ArticlesLocalDataSource>(
        () => ArticlesLocalDataSourceImpl(sl()))

    //Repositories
    ..registerFactory<ArticlesRepository>(
        () => ArticlesRepositoryImpl(sl(), sl()))

    //Use cases
    ..registerFactory(() => FetchArticles(sl()))
    ..registerFactory(() => DeleteFavorite(sl()))
    ..registerFactory(() => SaveFavorite(sl()))
    ..registerFactory(() => FetchFavorites(sl()))

    //Bloc
    ..registerLazySingleton(() => ArticlesBloc(fetchArticles: sl()))
    ..registerLazySingleton(
      () => FavoritesBloc(
        fetchFavorites: sl(),
        saveFavorite: sl(),
        deleteFavorite: sl(),
      ),
    );
}
