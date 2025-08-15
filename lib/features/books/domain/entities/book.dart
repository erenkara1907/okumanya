import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_extensions.dart';

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

  /// Returns formatted title with proper book title case
  String get formattedTitle => title.toBookTitleCase();

  /// Returns author initials for avatar
  String get authorInitials => author.getInitials();

  /// Returns last read time in relative format
  String? lastReadTimeRelative({String? locale}) {
    return lastReadAt?.toRelativeTime(locale: locale);
  }

  /// Returns formatted last read date
  String? lastReadDateFormatted({String? locale}) {
    return lastReadAt?.toFormattedDate(locale: locale);
  }

  /// Returns reading streak status
  bool get wasReadToday {
    return lastReadAt?.isToday ?? false;
  }

  /// Returns reading time category when last read
  String? getLastReadingTimeCategory({String? locale}) {
    return lastReadAt?.getReadingTimeCategory(locale: locale);
  }

  /// Returns truncated description for card display
  String? get shortDescription {
    return description?.truncateAtWord(100);
  }

  /// Returns search-friendly text combining title and author
  String get searchText {
    return '$title $author'.toSearchFormat();
  }

  /// Returns estimated reading time based on pages
  int? get estimatedReadingTime {
    if (totalPages == null) return null;
    // Assuming 250 words per page and 200 words per minute reading speed
    final totalWords = totalPages! * 250;
    return (totalWords / 200).ceil();
  }

  /// Returns time needed to complete remaining pages
  int? get timeToComplete {
    if (totalPages == null || currentPage == null) return null;
    final remainingPages = totalPages! - currentPage!;
    if (remainingPages <= 0) return 0;

    // Assuming 250 words per page and 200 words per minute reading speed
    final remainingWords = remainingPages * 250;
    return (remainingWords / 200).ceil();
  }
}
