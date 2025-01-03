import 'package:flutter/material.dart';
import 'package:news_circle/modules/news/domain/entities/article_entity.dart';

class NewsCardWidget extends StatelessWidget {
  const NewsCardWidget({
    super.key,
    required this.article,
    required this.isDisabled,
    required this.onTap,
  });

  final ArticleEntity article;
  final bool isDisabled;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                child: Image.network(
                  article.urlToImage ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image);
                  },
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      article.title ?? 'Unknown Title',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: isDisabled
                                ? Theme.of(context).colorScheme.secondary
                                : null,
                          ),
                    ),
                    Text(
                      article.description ?? 'Description Not Available',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDisabled
                                ? Theme.of(context).colorScheme.secondary
                                : null,
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
  }
}
