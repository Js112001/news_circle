import 'dart:convert';

import 'package:news_circle/modules/news/data/models/source_model.dart';
import 'package:news_circle/modules/news/domain/entities/article_entity.dart';

class ArticleResponseModel {
  final String? status;
  final String? code;
  final String? message;
  final SourceModel? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final DateTime? publishedAt;
  final String? content;

  ArticleResponseModel({
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

  ArticleResponseModel copyWith({
    String? status,
    String? code,
    String? message,
    SourceModel? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
  }) =>
      ArticleResponseModel(
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

  factory ArticleResponseModel.fromRawJson(String str) =>
      ArticleResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleResponseModel.fromJson(Map<String, dynamic> json) =>
      ArticleResponseModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        source: json["source"] == null
            ? null
            : SourceModel.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: json["publishedAt"] == null
            ? null
            : DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
        "source": source?.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt?.toIso8601String(),
        "content": content,
      };

  ArticleEntity toEntity() => ArticleEntity(
        status: status,
        code: code,
        message: message,
        source: source?.toEntity(),
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: publishedAt,
        content: content,
      );
}
