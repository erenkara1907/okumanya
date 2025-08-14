// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookModelImpl _$$BookModelImplFromJson(Map<String, dynamic> json) =>
    _$BookModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      category: json['category'] as String,
      imageUrl: json['image_url'] as String?,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String?,
      totalPages: (json['total_pages'] as num?)?.toInt(),
      currentPage: (json['current_page'] as num?)?.toInt(),
      lastReadAt: json['last_read_at'] == null
          ? null
          : DateTime.parse(json['last_read_at'] as String),
      isFavorite: json['is_favorite'] as bool? ?? false,
    );

Map<String, dynamic> _$$BookModelImplToJson(_$BookModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'category': instance.category,
      'image_url': instance.imageUrl,
      'progress': instance.progress,
      'description': instance.description,
      'total_pages': instance.totalPages,
      'current_page': instance.currentPage,
      'last_read_at': instance.lastReadAt?.toIso8601String(),
      'is_favorite': instance.isFavorite,
    };
