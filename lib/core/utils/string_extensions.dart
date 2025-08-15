/// Comprehensive string utility extensions for common operations
/// Provides text formatting, validation, and transformation methods
extension StringExtensions on String {
  /// Capitalize first letter of each word
  String toCapitalCase() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize()).join(' ');
  }

  /// Capitalize only the first letter of the string
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// Convert to sentence case (first letter uppercase, rest lowercase)
  String toSentenceCase() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }

  /// Remove extra whitespaces and trim
  String cleanWhitespace() {
    return trim().replaceAll(RegExp(r'\s+'), ' ');
  }

  /// Check if string is a valid email
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Check if string is a valid Turkish phone number
  bool get isValidTurkishPhone {
    // Turkish phone format: +90 5XX XXX XX XX or 05XX XXX XX XX
    final cleaned = replaceAll(RegExp(r'[^\d]'), '');
    return RegExp(r'^(90|0)?5\d{9}$').hasMatch(cleaned);
  }

  /// Check if string contains only letters (Turkish characters included)
  bool get isLettersOnly {
    return RegExp(r'^[a-zA-ZçğıöşüÇĞIİÖŞÜ\s]+$').hasMatch(this);
  }

  /// Check if string contains only numbers
  bool get isNumbersOnly {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  /// Check if string is alphanumeric
  bool get isAlphanumeric {
    return RegExp(r'^[a-zA-Z0-9çğıöşüÇĞIİÖŞÜ]+$').hasMatch(this);
  }

  /// Remove Turkish characters and convert to ASCII
  String removeAccents() {
    final turkishChars = {
      'ç': 'c',
      'Ç': 'C',
      'ğ': 'g',
      'Ğ': 'G',
      'ı': 'i',
      'I': 'I',
      'İ': 'I',
      'i': 'i',
      'ö': 'o',
      'Ö': 'O',
      'ş': 's',
      'Ş': 'S',
      'ü': 'u',
      'Ü': 'U',
    };

    String result = this;
    turkishChars.forEach((key, value) {
      result = result.replaceAll(key, value);
    });
    return result;
  }

  /// Convert to URL-friendly slug
  String toSlug() {
    return removeAccents()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-')
        .replaceAll(RegExp(r'-+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }

  /// Truncate string with ellipsis
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }

  /// Truncate string at word boundary
  String truncateAtWord(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;

    int lastSpace = substring(0, maxLength - suffix.length).lastIndexOf(' ');
    if (lastSpace == -1) lastSpace = maxLength - suffix.length;

    return '${substring(0, lastSpace)}$suffix';
  }

  /// Extract initials from name (e.g., "Eren Kara" -> "EK")
  String getInitials({int maxInitials = 2}) {
    final words = split(' ').where((word) => word.isNotEmpty).toList();
    if (words.isEmpty) return '';

    final initials =
        words.take(maxInitials).map((word) => word[0].toUpperCase());
    return initials.join();
  }

  /// Mask sensitive information (e.g., credit card, phone)
  String mask(
      {int visibleStart = 0, int visibleEnd = 4, String maskChar = '*'}) {
    if (length <= visibleStart + visibleEnd) return this;

    final start = substring(0, visibleStart);
    final end = substring(length - visibleEnd);
    final masked = maskChar * (length - visibleStart - visibleEnd);

    return '$start$masked$end';
  }

  /// Format as Turkish currency (e.g., "1.234,56 ₺")
  String toCurrency({String symbol = '₺', int decimals = 2}) {
    final number = double.tryParse(this);
    if (number == null) return this;

    final formatted = number
        .toStringAsFixed(decimals)
        .replaceAll('.', ',')
        .replaceAll(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), r'$1.');

    return '$formatted $symbol';
  }

  /// Parse currency string to double
  double? fromCurrency() {
    final cleaned = replaceAll(RegExp(r'[^\d,]'), '').replaceAll(',', '.');
    return double.tryParse(cleaned);
  }

  /// Format Turkish ID number (11 digits with spaces)
  String formatTurkishId() {
    if (length != 11 || !isNumbersOnly) return this;
    return '${substring(0, 3)} ${substring(3, 6)} ${substring(6, 8)} ${substring(8)}';
  }

  /// Format Turkish phone number
  String formatTurkishPhone() {
    final cleaned = replaceAll(RegExp(r'[^\d]'), '');

    if (cleaned.length == 11 && cleaned.startsWith('0')) {
      // 05XX XXX XX XX
      return '${cleaned.substring(0, 4)} ${cleaned.substring(4, 7)} ${cleaned.substring(7, 9)} ${cleaned.substring(9)}';
    } else if (cleaned.length == 12 && cleaned.startsWith('90')) {
      // +90 5XX XXX XX XX
      return '+90 ${cleaned.substring(2, 5)} ${cleaned.substring(5, 8)} ${cleaned.substring(8, 10)} ${cleaned.substring(10)}';
    }

    return this;
  }

  /// Check if string is a valid Turkish ID number
  bool get isValidTurkishId {
    if (length != 11 || !isNumbersOnly || startsWith('0')) return false;

    final digits = split('').map((e) => int.parse(e)).toList();

    // Turkish ID validation algorithm
    int sumOdd = digits[0] + digits[2] + digits[4] + digits[6] + digits[8];
    int sumEven = digits[1] + digits[3] + digits[5] + digits[7];

    int check1 = (sumOdd * 7 - sumEven) % 10;
    int check2 = (sumOdd + sumEven + digits[9]) % 10;

    return check1 == digits[9] && check2 == digits[10];
  }

  /// Count words in string
  int get wordCount {
    return split(RegExp(r'\s+')).where((word) => word.isNotEmpty).length;
  }

  /// Estimate reading time in minutes (average 200 words per minute)
  int get estimatedReadingTime {
    final words = wordCount;
    return (words / 200).ceil();
  }

  /// Extract hashtags from text
  List<String> extractHashtags() {
    final hashtags = <String>[];
    final matches = RegExp(r'#\w+').allMatches(this);

    for (final match in matches) {
      hashtags.add(substring(match.start + 1, match.end));
    }

    return hashtags;
  }

  /// Extract mentions from text
  List<String> extractMentions() {
    final mentions = <String>[];
    final matches = RegExp(r'@\w+').allMatches(this);

    for (final match in matches) {
      mentions.add(substring(match.start + 1, match.end));
    }

    return mentions;
  }

  /// Convert to book title case
  String toBookTitleCase() {
    final lowerCaseWords = {
      've',
      'ile',
      'için',
      'bir',
      'the',
      'and',
      'or',
      'but',
      'in',
      'on',
      'at',
      'to',
      'for',
      'of',
      'with'
    };
    final words = toLowerCase().split(' ');

    return words.asMap().entries.map((entry) {
      final index = entry.key;
      final word = entry.value;

      // Always capitalize first and last word
      if (index == 0 || index == words.length - 1) {
        return word.capitalize();
      }

      // Don't capitalize small words unless they're first or last
      if (lowerCaseWords.contains(word)) {
        return word;
      }

      return word.capitalize();
    }).join(' ');
  }

  /// Generate a random color from string hash
  String toColorHex() {
    int hash = 0;
    for (int i = 0; i < length; i++) {
      hash = codeUnitAt(i) + ((hash << 5) - hash);
    }

    final color = (hash & 0x00FFFFFF).toRadixString(16).toUpperCase();
    return '#${'000000'.substring(0, 6 - color.length)}$color';
  }

  /// Check if string contains profanity (basic Turkish words)
  bool get containsProfanity {
    final profanityWords = [
      'lanet',
      'kahretsin',
      'cehennem'
    ]; // Add more as needed
    final lowerText = toLowerCase();

    for (final word in profanityWords) {
      if (lowerText.contains(word)) return true;
    }

    return false;
  }

  /// Convert to search-friendly format
  String toSearchFormat() {
    return removeAccents()
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .cleanWhitespace();
  }

  /// Check if string is a valid ISBN
  bool get isValidISBN {
    final cleaned = replaceAll(RegExp(r'[^\dX]'), '');

    if (cleaned.length == 10) {
      return _isValidISBN10(cleaned);
    } else if (cleaned.length == 13) {
      return _isValidISBN13(cleaned);
    }

    return false;
  }

  bool _isValidISBN10(String isbn) {
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(isbn[i]) * (10 - i);
    }

    final lastChar = isbn[9];
    final checkDigit = lastChar == 'X' ? 10 : int.parse(lastChar);
    sum += checkDigit;

    return sum % 11 == 0;
  }

  bool _isValidISBN13(String isbn) {
    int sum = 0;
    for (int i = 0; i < 12; i++) {
      final digit = int.parse(isbn[i]);
      sum += (i % 2 == 0) ? digit : digit * 3;
    }

    final checkDigit = (10 - (sum % 10)) % 10;
    return checkDigit == int.parse(isbn[12]);
  }

  /// Format file size
  String formatFileSize() {
    final bytes = int.tryParse(this);
    if (bytes == null) return this;

    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    int index = 0;
    double size = bytes.toDouble();

    while (size >= 1024 && index < suffixes.length - 1) {
      size /= 1024;
      index++;
    }

    return '${size.toStringAsFixed(index == 0 ? 0 : 1)} ${suffixes[index]}';
  }

  /// Convert snake_case to camelCase
  String toCamelCase() {
    final words = split('_');
    if (words.isEmpty) return this;

    return words.first + words.skip(1).map((word) => word.capitalize()).join();
  }

  /// Convert camelCase to snake_case
  String toSnakeCase() {
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    ).replaceFirst(RegExp(r'^_'), '');
  }
}
