import 'package:news_circle/modules/news/domain/entities/source_entity.dart';
import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {
  final int? id;
  final String? status;
  final String? code;
  final String? message;
  final SourceEntity? source;
  final int? source_id;
  final String? source_name;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  ArticleEntity({
    this.id,
    this.status,
    this.code,
    this.message,
    this.source,
    this.source_id,
    this.source_name,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  ArticleEntity copyWith({
    int? id,
    String? status,
    String? code,
    String? message,
    SourceEntity? source,
    int? source_id,
    String? source_name,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
  }) =>
      ArticleEntity(
        id: id,
        status: status ?? this.status,
        code: code ?? this.code,
        message: message ?? this.message,
        source: source ?? this.source,
        source_id: source_id ?? this.source_id,
        source_name: source_name ?? this.source_name,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        urlToImage: urlToImage ?? this.urlToImage,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "code": code,
        "message": message,
        "source": source,
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt,
        "content": content,
      };

  @override
  List<Object?> get props => [
        status,
        code,
        message,
        source,
        author,
        title,
        description,
        url,
        urlToImage,
        publishedAt,
        content,
      ];
}
