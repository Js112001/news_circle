import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:news_circle/modules/news/presentation/views/article_detail_view.dart';
import 'package:news_circle/modules/news/presentation/views/article_web_view.dart';
import 'package:news_circle/modules/news/presentation/views/articles_listing_view.dart';
import 'package:news_circle/modules/news/presentation/views/home_view.dart';

class AppNavigator {
  GoRouter setupRouter() {
    return GoRouter(
      debugLogDiagnostics: true,
      initialLocation: HomeView.route,
      routes: [
        GoRoute(
          path: HomeView.route,
          builder: (context, state) => HomeView(
            title: 'News Circle',
          ),
        ),
        GoRoute(
          path: '/${ArticlesListingView.route}',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return ArticlesListingView(
              articleCategory: extra['articleCategory'],
            );
          },
        ),
        GoRoute(
          path: '/${ArticleDetailView.route}',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return ArticleDetailView(
              article: extra['article'],
            );
          },
        ),
        GoRoute(
          path: '/${ArticleWebView.route}',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            return ArticleWebView(
              url: extra['url'],
            );
          },
        ),
      ],
    );
  }

  static void pop(BuildContext context) {
    GoRouter.of(context).pop();
  }

  static void pushPath(
    BuildContext context,
    String path, {
    Map<String, String> params = const <String, String>{},
    Map<String, dynamic>? extra,
  }) {
    GoRouter.of(context).push(
      '/$path',
      extra: extra,
    );
  }

  static void pushPathReplacement(
    BuildContext context,
    String path, {
    Object? extra,
  }) {
    GoRouter.of(context).pushReplacement(
      '/$path',
      extra: extra,
    );
  }
}
