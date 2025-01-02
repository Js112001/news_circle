import 'package:flutter/material.dart';
import 'package:news_circle/core/routes/app_navigator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppNavigator().setupRouter();

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white60),
        useMaterial3: true,
      ),
      routerConfig: router,
      builder: (context, child) {
        return child!;
      },
    );
  }
}