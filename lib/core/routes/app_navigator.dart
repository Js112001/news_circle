import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:news_circle/modules/articles/presentation/views/home_view.dart';

class AppNavigator {
  GoRouter setupRouter() {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomeView(
            title: 'News Circle',
          ),
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
