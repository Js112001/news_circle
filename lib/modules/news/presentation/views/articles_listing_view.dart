import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_circle/core/routes/app_navigator.dart';
import 'package:news_circle/modules/news/domain/entities/article_entity.dart';
import 'package:news_circle/modules/news/presentation/blocs/home_bloc.dart';
import 'package:news_circle/modules/news/presentation/views/article_detail_view.dart';
import 'package:news_circle/modules/news/presentation/views/home_view.dart';
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            );
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
                        return InkWell(
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
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 16,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    height: 120,
                                    child: articles[index].urlToImage != null &&
                                            articles[index]
                                                .urlToImage!
                                                .isNotEmpty
                                        ? Image.network(
                                            articles[index].urlToImage!,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(Icons.image);
                                            },
                                          )
                                        : const Icon(Icons.image),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      spacing: 8,
                                      children: [
                                        Text(
                                          articles[index].title ??
                                              'Unknown Title',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                isDisabled ? Colors.grey : null,
                                          ),
                                        ),
                                        Text(
                                          articles[index].description ??
                                              'Description Not Available',
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                isDisabled ? Colors.grey : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  if (state.isPaginated)
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10,
              children: [
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<HomeBloc>(context)
                        .add(GetArticleEvent(category: 'business'));
                  },
                  child: Icon(
                    Icons.refresh,
                    size: 60,
                    color: Colors.black,
                  ),
                ),
                Text("Something went wrong. Try again"),
              ],
            ),
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
