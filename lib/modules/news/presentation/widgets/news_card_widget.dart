import 'package:flutter/material.dart';
import 'package:news_circle/modules/news/domain/entities/article_entity.dart';

class NewsCardWidget extends StatefulWidget {
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
  State<NewsCardWidget> createState() => _NewsCardWidgetState();
}

class _NewsCardWidgetState extends State<NewsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.primary,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              SizedBox(
                width: 100,
                height: 120,
                child: Image.network(
                  widget.article.urlToImage ?? '',
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
                      widget.article.title ?? 'Unknown Title',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: widget.isDisabled
                                ? Theme.of(context).colorScheme.secondary
                                : null,
                          ),
                    ),
                    Text(
                      widget.article.description ?? 'Description Not Available',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: widget.isDisabled
                                ? Theme.of(context).colorScheme.secondary
                                : null,
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.article.source?.name ??
                              widget.article.author ??
                              'Unknown Source',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        IconButton(
                          style: ButtonStyle(
                            foregroundColor: WidgetStatePropertyAll(
                              widget.isDisabled
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          onPressed: () {},
                          icon: Icon(
                            Icons.bookmark_border,
                          ),
                        ),
                      ],
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
