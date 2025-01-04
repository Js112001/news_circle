import 'package:equatable/equatable.dart';

class SourceEntity extends Equatable {
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

  @override
  List<Object?> get props => [id];
}
