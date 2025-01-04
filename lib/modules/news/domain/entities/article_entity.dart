
import 'package:news_circle/modules/news/domain/entities/source_entity.dart';

class ArticleEntity {
  final String? status;
  final String? code;
  final String? message;
  final SourceEntity? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  ArticleEntity({
    this.status,
    this.code,
    this.message,
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  ArticleEntity copyWith({
    String? status,
    String? code,
    String? message,
    SourceEntity? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
  }) =>
      ArticleEntity(
        status: status ?? this.status,
        code: code ?? this.code,
        message: message ?? this.message,
        source: source ?? this.source,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        urlToImage: urlToImage ?? this.urlToImage,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
      );

}
