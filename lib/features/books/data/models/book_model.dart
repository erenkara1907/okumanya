import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/book.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

/// Data model for Book entity with JSON serialization
@freezed
class BookModel with _$BookModel {
  const factory BookModel({
    required String id,
    required String title,
    required String author,
    required String category,
    @JsonKey(name: 'image_url') String? imageUrl,
    @Default(0.0) double progress,
    String? description,
    @JsonKey(name: 'total_pages') int? totalPages,
    @JsonKey(name: 'current_page') int? currentPage,
    @JsonKey(name: 'last_read_at') DateTime? lastReadAt,
    @JsonKey(name: 'is_favorite') @Default(false) bool isFavorite,
  }) = _BookModel;

  const BookModel._();

  /// Creates BookModel from JSON
  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);

  /// Converts BookModel to domain entity
  Book toDomain() => Book(
        id: id,
        title: title,
        author: author,
        category: category,
        imageUrl: imageUrl,
        progress: progress,
        description: description,
        totalPages: totalPages,
        currentPage: currentPage,
        lastReadAt: lastReadAt,
        isFavorite: isFavorite,
      );

  /// Creates BookModel from domain entity
  factory BookModel.fromDomain(Book book) => BookModel(
        id: book.id,
        title: book.title,
        author: book.author,
        category: book.category,
        imageUrl: book.imageUrl,
        progress: book.progress,
        description: book.description,
        totalPages: book.totalPages,
        currentPage: book.currentPage,
        lastReadAt: book.lastReadAt,
        isFavorite: book.isFavorite,
      );
}
