import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_circle/core/routes/app_navigator.dart';
import 'package:news_circle/modules/news/presentation/blocs/home_bloc.dart';
import 'package:news_circle/modules/news/presentation/views/home_view.dart';
import 'package:news_circle/modules/news/presentation/widgets/loading_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatefulWidget {
  const ArticleWebView({
    super.key,
    required this.url,
  });

  final String url;

  static final String route = 'article-web-view';

  @override
  State<ArticleWebView> createState() => _ArticleWebViewState();
}

class _ArticleWebViewState extends State<ArticleWebView> {
  late WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: isLoading
          ? LoadingWidget()
          : WebViewWidget(
              controller: controller,
            ),
    );
  }
}
