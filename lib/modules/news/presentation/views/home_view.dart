import 'package:flutter/material.dart';
import 'package:news_circle/core/routes/app_navigator.dart';
import 'package:news_circle/modules/news/presentation/views/articles_listing_view.dart';
import 'package:news_circle/utils/enums.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.title});

  final String title;

  static final String route = '/';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> categories = ['Top Headlines', 'Technology', 'Sports'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: GestureDetector(
              onTap: () {
                AppNavigator.pushPath(
                  context,
                  ArticlesListingView.route,
                  extra: {
                    'articleCategory': _getArticleCategory(categories[index]),
                  },
                );
              },
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        categories[index],
                        style: TextStyle(fontSize: 22),
                      ),
                      Icon(Icons.arrow_circle_right_rounded)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          {
            'icon': Icon(Icons.house_outlined),
            'label': 'Home',
          },
          {
            'icon': Icon(Icons.bookmark_border),
            'label': 'Saved',
          },
          {
            'icon': Icon(Icons.settings),
            'label': 'Preferences',
          },
        ]
            .map(
              (e) => BottomNavigationBarItem(
                icon: e['icon'] as Widget,
                label: e['label'] as String,
              ),
            )
            .toList(),
        showSelectedLabels: false,
        selectedIconTheme: IconThemeData(size: 40),
        onTap: (value) {},
      ),
    );
  }

  ArticleCategory _getArticleCategory(String category) {
    switch (category) {
      case 'Top Headlines':
        return ArticleCategory.all;
      case 'Technology':
        return ArticleCategory.technology;
      case 'Sports':
        return ArticleCategory.sports;
      default:
        return ArticleCategory.all;
    }
  }
}
