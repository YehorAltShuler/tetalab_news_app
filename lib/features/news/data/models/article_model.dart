import 'dart:convert';

import 'package:tetalab_test_task/features/news/domain/entities/article.dart';
import 'package:uuid/uuid.dart';

class ArticleModel extends Article {
  ArticleModel({
    required super.id,
    // required super.sourceId,
    // required super.sourceName,
    required super.author,
    required super.title,
    required super.description,
    required super.url,
    required super.urlToImage,
    required super.publishedAt,
    required super.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      // 'sourceId': sourceId,
      // 'sourceName': sourceName,
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['id'] ?? const Uuid().v4(),
      // sourceId: map['source']['id'] ?? '',
      // sourceName: map['source']['name'] ?? '',
      author: map['author'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      url: map['url'] ?? '',
      urlToImage: map['urlToImage'] ?? '',
      publishedAt: map['publishedAt'] ?? '',
      content: map['content'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleModel.fromJson(String source) =>
      ArticleModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
