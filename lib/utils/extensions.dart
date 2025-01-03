import 'package:news_circle/utils/enums.dart';

extension ArticleCategoryExtensions on ArticleCategory {
  String toCategoryString() {
    switch (this) {
      case ArticleCategory.all:
        return 'all';
      case ArticleCategory.technology:
        return 'technology';
      case ArticleCategory.sports:
        return 'sports';
      case ArticleCategory.business:
        return 'business';
    }
  }
}

extension StringExtensions on String {
  String capitalize() {
    final firstChar = this[0].toUpperCase();

    final result = firstChar + substring(1);

    return result;
  }
}
