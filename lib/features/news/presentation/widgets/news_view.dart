import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetalab_test_task/features/news/presentation/bloc/remote/articles_bloc.dart';

import '../../domain/entities/article.dart';
import 'article_tile.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView>
    with AutomaticKeepAliveClientMixin<NewsView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ArticlesBloc, ArticlesState>(builder: (_, state) {
      if (state is ArticlesLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is ArticlesFailure) {
        return const Center(child: Icon(Icons.error_outline));
      }
      if (state is ArticlesDisplaySuccess) {
        return _buildArticlesView(context, state.articles);
      }
      return const SizedBox();
    });
  }

  _buildArticlesView(BuildContext context, List<Article> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return ArticleTile(article: article);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
