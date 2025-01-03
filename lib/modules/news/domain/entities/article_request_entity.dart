class ArticleRequestEntity {
  final String? category;
  final int? page;

  ArticleRequestEntity({ this.category, this.page});

  @override
  String toString() {
    return 'ArticleRequestEntity(category: $category, page: $page)';
  }
}