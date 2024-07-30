import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetalab_test_task/features/news/presentation/widgets/article_tile.dart';

import '../../domain/entities/article.dart';
import '../bloc/local/favorites_bloc.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView>
    with AutomaticKeepAliveClientMixin<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<FavoritesBloc, FavoritesState>(builder: (_, state) {
      if (state is FavoritesLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is FavoritesFailure) {
        return const Center(child: Icon(Icons.error_outline));
      }
      if (state is FavoritesDisplaySuccess) {
        return _buildFavoritesView(context, state.favorites);
      }
      return const SizedBox();
    });
  }

  _buildFavoritesView(BuildContext context, List<Article> favorites) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final favorite = favorites[index];
        return Dismissible(
            onDismissed: (direction) {
              context
                  .read<FavoritesBloc>()
                  .add(FavoriteDeleteEvent(favoriteId: favorite.id));
            },
            key: ValueKey(favorites[index]),
            background: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red.withOpacity(0.75),
                ),
                child: const Icon(Icons.delete),
              ),
            ),
            child: ArticleTile(article: favorite));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
