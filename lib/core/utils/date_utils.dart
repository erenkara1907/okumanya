import 'package:intl/intl.dart';

/// Comprehensive date utility extensions for DateTime objects
/// Provides localized formatting, relative time, and common date operations
extension DateUtils on DateTime {
  /// Turkish date formatter with day/month names in Turkish
  static final DateFormat _turkishDateFormat =
      DateFormat('d MMMM yyyy', 'tr_TR');
  static final DateFormat _turkishTimeFormat = DateFormat('HH:mm', 'tr_TR');
  static final DateFormat _turkishDateTimeFormat =
      DateFormat('d MMMM yyyy HH:mm', 'tr_TR');

  /// English date formatter
  static final DateFormat _englishDateFormat =
      DateFormat('MMMM d, yyyy', 'en_US');
  static final DateFormat _englishTimeFormat = DateFormat('h:mm a', 'en_US');
  static final DateFormat _englishDateTimeFormat =
      DateFormat('MMMM d, yyyy h:mm a', 'en_US');

  /// Get formatted date string for current locale
  String toFormattedDate({String? locale}) {
    final selectedLocale = locale ?? 'tr_TR';
    if (selectedLocale.startsWith('tr')) {
      return _turkishDateFormat.format(this);
    } else {
      return _englishDateFormat.format(this);
    }
  }

  /// Get formatted time string for current locale
  String toFormattedTime({String? locale}) {
    final selectedLocale = locale ?? 'tr_TR';
    if (selectedLocale.startsWith('tr')) {
      return _turkishTimeFormat.format(this);
    } else {
      return _englishTimeFormat.format(this);
    }
  }

  /// Get formatted date and time string for current locale
  String toFormattedDateTime({String? locale}) {
    final selectedLocale = locale ?? 'tr_TR';
    if (selectedLocale.startsWith('tr')) {
      return _turkishDateTimeFormat.format(this);
    } else {
      return _englishDateTimeFormat.format(this);
    }
  }

  /// Get relative time description (e.g., "2 gün önce", "3 hours ago")
  String toRelativeTime({String? locale}) {
    final now = DateTime.now();
    final difference = now.difference(this);
    final selectedLocale = locale ?? 'tr_TR';
    final isTurkish = selectedLocale.startsWith('tr');

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return isTurkish
          ? '$years ${years == 1 ? 'yıl' : 'yıl'} önce'
          : '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return isTurkish
          ? '$months ${months == 1 ? 'ay' : 'ay'} önce'
          : '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return isTurkish
          ? '${difference.inDays} ${difference.inDays == 1 ? 'gün' : 'gün'} önce'
          : '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return isTurkish
          ? '${difference.inHours} ${difference.inHours == 1 ? 'saat' : 'saat'} önce'
          : '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return isTurkish
          ? '${difference.inMinutes} ${difference.inMinutes == 1 ? 'dakika' : 'dakika'} önce'
          : '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return isTurkish ? 'Az önce' : 'Just now';
    }
  }

  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is this week
  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  /// Check if date is this month
  bool get isThisMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  /// Check if date is this year
  bool get isThisYear {
    final now = DateTime.now();
    return year == now.year;
  }

  /// Get start of day (00:00:00)
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }

  /// Get end of day (23:59:59)
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }

  /// Get start of week (Monday)
  DateTime get startOfWeek {
    return subtract(Duration(days: weekday - 1)).startOfDay;
  }

  /// Get end of week (Sunday)
  DateTime get endOfWeek {
    return add(Duration(days: 7 - weekday)).endOfDay;
  }

  /// Get start of month
  DateTime get startOfMonth {
    return DateTime(year, month, 1);
  }

  /// Get end of month
  DateTime get endOfMonth {
    return DateTime(year, month + 1, 0, 23, 59, 59, 999);
  }

  /// Get start of year
  DateTime get startOfYear {
    return DateTime(year, 1, 1);
  }

  /// Get end of year
  DateTime get endOfYear {
    return DateTime(year, 12, 31, 23, 59, 59, 999);
  }

  /// Add business days (excluding weekends)
  DateTime addBusinessDays(int days) {
    DateTime result = this;
    int daysToAdd = days;

    while (daysToAdd > 0) {
      result = result.add(const Duration(days: 1));
      if (result.weekday <= 5) {
        // Monday = 1, Friday = 5
        daysToAdd--;
      }
    }

    return result;
  }

  /// Calculate age in years from birth date
  int get ageFromBirthDate {
    final now = DateTime.now();
    int age = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    return age;
  }

  /// Format for reading session duration
  String toReadingDuration() {
    final duration = DateTime.now().difference(this);

    if (duration.inHours > 0) {
      return '${duration.inHours} saat ${duration.inMinutes.remainder(60)} dakika';
    } else {
      return '${duration.inMinutes} dakika';
    }
  }

  /// Format for book publication date
  String toPublicationDate({String? locale}) {
    final selectedLocale = locale ?? 'tr_TR';
    if (selectedLocale.startsWith('tr')) {
      return DateFormat('yyyy').format(this);
    } else {
      return DateFormat('yyyy').format(this);
    }
  }

  /// Check if date is within reading hours (typically 6 AM to 10 PM)
  bool get isReadingHours {
    return hour >= 6 && hour <= 22;
  }

  /// Get reading time category
  String getReadingTimeCategory({String? locale}) {
    final isTurkish = (locale ?? 'tr_TR').startsWith('tr');

    if (hour >= 5 && hour < 12) {
      return isTurkish ? 'Sabah' : 'Morning';
    } else if (hour >= 12 && hour < 17) {
      return isTurkish ? 'Öğleden Sonra' : 'Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return isTurkish ? 'Akşam' : 'Evening';
    } else {
      return isTurkish ? 'Gece' : 'Night';
    }
  }
}

/// Utility class for date operations
class DateUtilsHelper {
  /// Parse string date to DateTime with multiple format support
  static DateTime? parseDate(String dateString) {
    final formats = [
      'yyyy-MM-dd',
      'dd/MM/yyyy',
      'MM/dd/yyyy',
      'yyyy-MM-dd HH:mm:ss',
      'dd.MM.yyyy',
      'dd-MM-yyyy',
    ];

    for (final format in formats) {
      try {
        return DateFormat(format).parse(dateString);
      } catch (e) {
        continue;
      }
    }

    return null;
  }

  /// Get list of dates between two dates
  static List<DateTime> getDatesBetween(DateTime start, DateTime end) {
    final dates = <DateTime>[];
    DateTime current = start.startOfDay;
    final endDate = end.startOfDay;

    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      dates.add(current);
      current = current.add(const Duration(days: 1));
    }

    return dates;
  }

  /// Calculate reading streak days
  static int calculateReadingStreak(List<DateTime> readingDates) {
    if (readingDates.isEmpty) return 0;

    final sortedDates = readingDates.map((d) => d.startOfDay).toSet().toList()
      ..sort((a, b) => b.compareTo(a)); // Sort descending

    int streak = 0;
    DateTime expectedDate = DateTime.now().startOfDay;

    for (final date in sortedDates) {
      if (date.isAtSameMomentAs(expectedDate)) {
        streak++;
        expectedDate = expectedDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  /// Get this week's reading days
  static List<DateTime> getThisWeekReadingDays(List<DateTime> readingDates) {
    final now = DateTime.now();
    final startOfWeek = now.startOfWeek;
    final endOfWeek = now.endOfWeek;

    return readingDates
        .where((date) =>
            date.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
            date.isBefore(endOfWeek.add(const Duration(days: 1))))
        .toList();
  }
}
