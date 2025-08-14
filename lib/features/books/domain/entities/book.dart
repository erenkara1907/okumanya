import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';

/// Domain entity representing a book
@freezed
class Book with _$Book {
  const factory Book({
    required String id,
    required String title,
    required String author,
    required String category,
    String? imageUrl,
    @Default(0.0) double progress,
    String? description,
    int? totalPages,
    int? currentPage,
    DateTime? lastReadAt,
    @Default(false) bool isFavorite,
  }) = _Book;

  const Book._();

  /// Calculates reading progress as percentage
  double get progressPercentage => progress.clamp(0.0, 1.0);

  /// Checks if the book has been started
  bool get isStarted => progress > 0.0;

  /// Checks if the book is completed
  bool get isCompleted => progress >= 1.0;

  /// Returns formatted progress text
  String get progressText {
    if (totalPages != null && currentPage != null) {
      return '$currentPage / $totalPages';
    }
    return '${(progressPercentage * 100).toInt()}%';
  }
}