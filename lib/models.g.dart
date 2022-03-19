// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as int,
      name: json['name'] as String,
      children:
          (json['children'] as List<dynamic>).map((e) => e as int).toList(),
      parentCategoryId: json['parent_category_id'] as int?,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'children': instance.children,
      'parent_category_id': instance.parentCategoryId,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
    };
