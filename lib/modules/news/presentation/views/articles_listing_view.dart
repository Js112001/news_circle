import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_circle/core/routes/app_navigator.dart';
import 'package:news_circle/modules/news/domain/entities/article_entity.dart';
import 'package:news_circle/modules/news/presentation/blocs/home_bloc.dart';
import 'package:news_circle/modules/news/presentation/views/article_detail_view.dart';
import 'package:news_circle/modules/news/presentation/views/home_view.dart';
import 'package:news_circle/modules/news/presentation/widgets/loading_widget.dart';
import 'package:news_circle/modules/news/presentation/widgets/news_card_widget.dart';
import 'package:news_circle/modules/news/presentation/widgets/retry_widget.dart';
import 'package:news_circle/utils/enums.dart';
import 'package:news_circle/utils/extensions.dart';

class ArticlesListingView extends StatefulWidget {
  const ArticlesListingView({
    super.key,
    required this.articleCategory,
  });

  static final String route = 'articles';

  final ArticleCategory articleCategory;

  @override
  State<ArticlesListingView> createState() => _ArticlesListingViewState();
}

class _ArticlesListingViewState extends State<ArticlesListingView> {
  late ScrollController scrollController;
  Timer? _debounce;
  List<ArticleEntity> articles = [];
  var page = 1;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(
      GetArticleEvent(
        category: widget.articleCategory.toCategoryString(),
        page: page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.articleCategory.toCategoryString().capitalize()} articles',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              AppNavigator.pushPathReplacement(context, HomeView.route);
            },
            icon: Icon(
              Icons.house_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is InitialState || state is LoadingState) {
            return LoadingWidget();
          } else if (state is GetArticleSuccessState) {
            articles.addAll(state.articles);
            scrollController = ScrollController();
            scrollController.addListener(_scrollListener);
            return RefreshIndicator(
              onRefresh: () async {
                articles = [];
                BlocProvider.of<HomeBloc>(context).add(
                  GetArticleEvent(
                    category: widget.articleCategory.toCategoryString(),
                  ),
                );
              },
              color: Theme.of(context).colorScheme.onPrimary,
              child: Column(
                spacing: 20,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: articles.length,
                      controller: scrollController,
                      itemBuilder: (context, index) {
                        var isDisabled = articles[index].content == null ||
                            articles[index].content == '[Removed]';
                        return NewsCardWidget(
                          onTap: isDisabled
                              ? null
                              : () {
                                  AppNavigator.pushPath(
                                    context,
                                    ArticleDetailView.route,
                                    extra: {
                                      'article': articles[index],
                                    },
                                  );
                                },
                          article: articles[index],
                          isDisabled: isDisabled,
                        );
                      },
                    ),
                  ),
                  if (state.isPaginated) LoadingWidget(),
                ],
              ),
            );
          }
          return RetryWidget(
            onRetry: () {
              BlocProvider.of<HomeBloc>(context).add(
                GetArticleEvent(
                  category: widget.articleCategory.toCategoryString(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void deactivate() {
    BlocProvider.of<HomeBloc>(context).add(InitialEvent());
    super.deactivate();
  }

  @override
  void dispose() {
    scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      page = page + 1;
      if (_debounce?.isActive ?? false) {
        _debounce?.cancel();
      } else {
        _debounce = Timer(
          Duration(milliseconds: 500),
          () {
            BlocProvider.of<HomeBloc>(context).add(
              GetArticleEvent(
                category: widget.articleCategory.toCategoryString(),
                page: page,
              ),
            );
          },
        );
      }
    }
  }
}
