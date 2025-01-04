import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_circle/core/routes/app_navigator.dart';
import 'package:news_circle/modules/news/domain/entities/article_entity.dart';
import 'package:news_circle/modules/news/presentation/blocs/home_bloc.dart';
import 'package:news_circle/modules/news/presentation/views/article_web_view.dart';
import 'package:news_circle/modules/news/presentation/views/home_view.dart';
import 'package:news_circle/utils/constants.dart';
import 'package:news_circle/utils/extensions.dart';

class ArticleDetailView extends StatelessWidget {
  const ArticleDetailView({
    super.key,
    required this.article,
  });

  final ArticleEntity article;

  static final String route = 'article-detail-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'article detail'.capitalize(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<HomeBloc>(context).add(InitialEvent());
              AppNavigator.pushPathReplacement(context, HomeView.route);
            },
            icon: Icon(
              Icons.house_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        spacing: 10,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 3,
            child: Image.network(
              article.urlToImage ?? '',
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              article.title ?? StringConstants.noTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              article.content ?? StringConstants.noContentAvailable,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white70,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.source?.name ?? 'Unknown Source',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2,
                      child: Text(
                        'Author: ${article.author ?? 'Unknown'}',
                        softWrap: true,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                if (article.url != null && article.url!.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      AppNavigator.pushPath(
                        context,
                        ArticleWebView.route,
                        extra: {
                          'url': article.url,
                        },
                      );
                    },
                    child: Text(
                      StringConstants.readMore,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
