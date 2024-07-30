import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tetalab_test_task/features/news/presentation/bloc/local/favorites_bloc.dart';
import 'package:tetalab_test_task/features/news/presentation/bloc/remote/articles_bloc.dart';

import 'features/news/presentation/pages/news_page.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializedDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoritesBloc>(
          create: (_) => sl<FavoritesBloc>()..add(const FavoritesFetchEvent()),
        ),
        BlocProvider<ArticlesBloc>(
          create: (_) =>
              sl<ArticlesBloc>()..add(const ArticlesFetchEvent(null)),
        ),
      ],
      child: MaterialApp(
        title: 'Tetalab Test Task',
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        home: const NewsPage(),
      ),
    );
  }
}
