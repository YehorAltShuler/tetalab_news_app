import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/article.dart';
import '../bloc/local/favorites_bloc.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({super.key, required this.article});
  final Article article;

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  void _showSnackBar(BuildContext context, Widget content) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: content,
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
  }

  void _saveArticle(BuildContext context, Article article) {
    context.read<FavoritesBloc>().add(FavoriteSaveEvent(
          id: article.id,
          // sourceId: article.sourceId,
          // sourceName: article.sourceName,
          author: article.author,
          title: article.title,
          description: article.description,
          url: article.url,
          urlToImage: article.urlToImage,
          publishedAt: article.publishedAt,
          content: article.content,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          article.urlToImage.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    article.urlToImage,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const CircularProgressIndicator();
                    },
                  ),
                )
              : const SizedBox(),
          ListTile(
            leading: ClipOval(
              child: Image.asset('assets/images/news_logo.png'),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        article.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(DateFormat('HH:mm')
                                .format(DateTime.parse(article.publishedAt))),
                            IconButton(
                                onPressed: () {
                                  _launchUrl(article.url);
                                },
                                icon: const Icon(Icons.arrow_forward)),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              _saveArticle(context, article);
                              _showSnackBar(context, const Text('Done!'));
                            },
                            icon: const Icon(Icons.bookmark))
                      ],
                    ),
                  ],
                ),
                article.author.isEmpty
                    ? const SizedBox()
                    : Text(
                        article.author,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                Text(
                  article.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
