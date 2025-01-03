import 'dart:convert';

class SourceEntity {
  final String? id;
  final String? name;

  SourceEntity({
    this.id,
    this.name,
  });

  SourceEntity copyWith({
    String? id,
    String? name,
  }) =>
      SourceEntity(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory SourceEntity.fromRawJson(String str) =>
      SourceEntity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SourceEntity.fromJson(Map<String, dynamic> json) => SourceEntity(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
