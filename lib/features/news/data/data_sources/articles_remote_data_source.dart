import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'package:retrofit/retrofit.dart';
import 'package:tetalab_test_task/features/news/data/models/article_model.dart';

import '../../../../core/constants/app_constants.dart';

part 'news_remote_data_source.g.dart';

@RestApi(baseUrl: AppConstants.newsApiBaseUrl)
abstract class ArticlesRemoteDataSource {
  factory ArticlesRemoteDataSource(Dio dio, {String baseUrl}) =
      _ArticlesRemoteDataSource;

  @GET('/top-headlines')
  Future<HttpResponse<List<ArticleModel>>> fetchArticles({
    @Query('apiKey') String apiKey = AppConstants.apiKey,
    @Query('country') String? country = 'ua',
    @Query('q') String? q,
  });
}
