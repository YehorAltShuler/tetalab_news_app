import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:tetalab_test_task/features/news/data/models/article_model.dart';

abstract interface class ArticlesLocalDataSource {
  List<ArticleModel> loadLocalArticles();
  void deleteLocalArticle(String articleId);
  void saveLocalArticle(ArticleModel article);
}

class ArticlesLocalDataSourceImpl implements ArticlesLocalDataSource {
  final Box _box;

  ArticlesLocalDataSourceImpl(this._box);

  @override
  List<ArticleModel> loadLocalArticles() {
    List<ArticleModel> articles = [];
    _box.read(() {
      final boxKeys = _box.keys;
      Logger().e(boxKeys);
      for (int i = 0; i < _box.length; i++) {
        articles.add(ArticleModel.fromJson(_box.get(_box.keys[i])));
      }
    });
    Logger().w(articles);
    return articles;
  }

  @override
  void deleteLocalArticle(String recordId) {
    _box.delete(recordId);
  }

  @override
  void saveLocalArticle(ArticleModel article) {
    if (_box.containsKey(article.id)) {
      _box.delete(article.id);
    } else {
      _box.put(article.id, article.toJson());
    }
  }
}
