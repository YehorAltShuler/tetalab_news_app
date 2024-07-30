import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetalab_test_task/features/news/presentation/bloc/remote/articles_bloc.dart';
import 'package:tetalab_test_task/features/news/presentation/widgets/favorites_view.dart';

import '../widgets/news_view.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for news',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSubmitted: (value) {
                      context
                          .read<ArticlesBloc>()
                          .add(ArticlesFetchEvent(searchController.text));
                    },
                  ),
                ),
                const TabBar(
                  tabs: [
                    Tab(text: 'News'),
                    Tab(text: 'Favorites'),
                  ],
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              NewsView(),
              FavoritesView(),
            ],
          ),
        ),
      ),
    );
  }
}
