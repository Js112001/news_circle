import 'dart:convert';

import 'package:news_circle/modules/news/domain/entities/source_entity.dart';

class SourceModel extends SourceEntity {
  final String? id;
  final String? name;

  SourceModel({
    this.id,
    this.name,
  }) : super(id: id, name: name);

  SourceModel copyWith({
    String? id,
    String? name,
  }) =>
      SourceModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory SourceModel.fromRawJson(String str) =>
      SourceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SourceModel.fromJson(Map<String, dynamic> json) => SourceModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  SourceEntity toEntity() => SourceEntity(id: id, name: name);
}
