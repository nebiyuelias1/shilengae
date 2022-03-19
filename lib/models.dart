import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Category extends Equatable {
  final int id;
  final String name;
  final List<int> children;
  final int? parentCategoryId;
  final String status;
  final DateTime createdAt;

  const Category({
    required this.id,
    required this.name,
    required this.children,
    required this.parentCategoryId,
    required this.status,
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props =>
      [id, name, children, parentCategoryId, status, createdAt];
}
