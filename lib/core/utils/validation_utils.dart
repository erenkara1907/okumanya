/// Comprehensive validation utilities for form inputs and data validation
/// Provides validation methods for common input types with Turkish locale support
class ValidationUtils {
  // Private constructor to prevent instantiation
  ValidationUtils._();

  /// Validate email address
  static String? validateEmail(String? value, {String? locale}) {
    if (value == null || value.isEmpty) {
      return _getLocalizedMessage('email_required', locale);
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return _getLocalizedMessage('email_invalid', locale);
    }

    return null;
  }

  /// Validate password with customizable criteria
  static String? validatePassword(
    String? value, {
    int minLength = 6,
    bool requireUppercase = false,
    bool requireLowercase = false,
    bool requireNumbers = false,
    bool requireSpecialChars = false,
    String? locale,
  }) {
    if (value == null || value.isEmpty) {
      return _getLocalizedMessage('password_required', locale);
    }

    if (value.length < minLength) {
      return _getLocalizedMessage('password_min_length', locale, minLength);
    }

    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return _getLocalizedMessage('password_uppercase', locale);
    }

    if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      return _getLocalizedMessage('password_lowercase', locale);
    }

    if (requireNumbers && !value.contains(RegExp(r'[0-9]'))) {
      return _getLocalizedMessage('password_numbers', locale);
    }

    if (requireSpecialChars &&
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return _getLocalizedMessage('password_special_chars', locale);
    }

    return null;
  }

  /// Validate password confirmation
  static String? validatePasswordConfirmation(
    String? value,
    String? originalPassword, {
    String? locale,
  }) {
    if (value == null || value.isEmpty) {
      return _getLocalizedMessage('password_confirmation_required', locale);
    }

    if (value != originalPassword) {
      return _getLocalizedMessage('password_mismatch', locale);
    }

    return null;
  }

  /// Validate Turkish phone number
  static String? validateTurkishPhone(String? value, {String? locale}) {
    if (value == null || value.isEmpty) {
      return _getLocalizedMessage('phone_required', locale);
    }

    final cleaned = value.replaceAll(RegExp(r'[^\d]'), '');

    // Turkish phone formats: +90 5XX XXX XX XX or 05XX XXX XX XX
    if (!RegExp(r'^(90|0)?5\d{9}$').hasMatch(cleaned)) {
      return _getLocalizedMessage('phone_invalid', locale);
    }

    return null;
  }

  /// Validate Turkish ID number
  static String? validateTurkishId(String? value, {String? locale}) {
    if (value == null || value.isEmpty) {
      return _getLocalizedMessage('id_required', locale);
    }

    final cleaned = value.replaceAll(RegExp(r'[^\d]'), '');

    if (cleaned.length != 11) {
      return _getLocalizedMessage('id_length', locale);
    }

    if (cleaned.startsWith('0')) {
      return _getLocalizedMessage('id_invalid', locale);
    }

    // Turkish ID validation algorithm
    final digits = cleaned.split('').map((e) => int.parse(e)).toList();

    int sumOdd = digits[0] + digits[2] + digits[4] + digits[6] + digits[8];
    int sumEven = digits[1] + digits[3] + digits[5] + digits[7];

    int check1 = (sumOdd * 7 - sumEven) % 10;
    int check2 = (sumOdd + sumEven + digits[9]) % 10;

    if (check1 != digits[9] || check2 != digits[10]) {
      return _getLocalizedMessage('id_invalid', locale);
    }

    return null;
  }

  /// Validate name (only letters and spaces, Turkish characters included)
  static String? validateName(String? value,
      {int minLength = 2, int maxLength = 50, String? locale}) {
    if (value == null || value.isEmpty) {
      return _getLocalizedMessage('name_required', locale);
    }

    if (value.trim().length < minLength) {
      return _getLocalizedMessage('name_min_length', locale, minLength);
    }

    if (value.length > maxLength) {
      return _getLocalizedMessage('name_max_length', locale, maxLength);
    }

    if (!RegExp(r'^[a-zA-ZçğıöşüÇĞIİÖŞÜ\s]+$').hasMatch(value)) {
      return _getLocalizedMessage('name_invalid', locale);
    }

    return null;
  }

  /// Validate required field
  static String? validateRequired(String? value,
      {String? fieldName, String? locale}) {
    if (value == null || value.trim().isEmpty) {
      return _getLocalizedMessage('field_required', locale, 0, fieldName);
    }
    return null;
  }

  /// Validate string length
  static String? validateLength(
    String? value, {
    int? minLength,
    int? maxLength,
    String? fieldName,
    String? locale,
  }) {
    if (value == null) return null;

    if (minLength != null && value.length < minLength) {
      return _getLocalizedMessage(
          'field_min_length', locale, minLength, fieldName);
    }

    if (maxLength != null && value.length > maxLength) {
      return _getLocalizedMessage(
          'field_max_length', locale, maxLength, fieldName);
    }

    return null;
  }

  /// Validate numeric input
  static String? validateNumeric(String? value, {String? locale}) {
    if (value == null || value.isEmpty) {
      return _getLocalizedMessage('numeric_required', locale);
    }

    if (double.tryParse(value) == null) {
      return _getLocalizedMessage('numeric_invalid', locale);
    }

    return null;
  }

  /// Validate numeric range
  static String? validateNumericRange(
    String? value, {
    double? min,
    double? max,
    String? locale,
  }) {
    if (value == null || value.isEmpty) return null;

    final number = double.tryParse(value);
    if (number == null) {
      return _getLocalizedMessage('numeric_invalid', locale);
    }

    if (min != null && number < min) {
      return _getLocalizedMessage('numeric_min', locale, min.toInt());
    }

    if (max != null && number > max) {
      return _getLocalizedMessage('numeric_max', locale, max.toInt());
    }

    return null;
  }

  /// Validate date
  static String? validateDate(String? value, {String? locale}) {
    if (value == null || value.isEmpty) {
      return _getLocalizedMessage('date_required', locale);
    }

    try {
      DateTime.parse(value);
      return null;
    } catch (e) {
      return _getLocalizedMessage('date_invalid', locale);
    }
  }

  /// Validate date range
  static String? validateDateRange(
    String? value, {
    DateTime? minDate,
    DateTime? maxDate,
    String? locale,
  }) {
    if (value == null || value.isEmpty) return null;

    DateTime? date;
    try {
      date = DateTime.parse(value);
    } catch (e) {
      return _getLocalizedMessage('date_invalid', locale);
    }

    if (minDate != null && date.isBefore(minDate)) {
      return _getLocalizedMessage('date_min', locale);
    }

    if (maxDate != null && date.isAfter(maxDate)) {
      return _getLocalizedMessage('date_max', locale);
    }

    return null;
  }

  /// Validate age (must be between min and max)
  static String? validateAge(String? value,
      {int minAge = 0, int maxAge = 120, String? locale}) {
    if (value == null || value.isEmpty) {
      return _getLocalizedMessage('age_required', locale);
    }

    final age = int.tryParse(value);
    if (age == null) {
      return _getLocalizedMessage('age_invalid', locale);
    }

    if (age < minAge || age > maxAge) {
      return _getLocalizedMessage(
          'age_range', locale, minAge, maxAge.toString());
    }

    return null;
  }

  /// Validate URL
  static String? validateUrl(String? value, {String? locale}) {
    if (value == null || value.isEmpty) {
      return _getLocalizedMessage('url_required', locale);
    }

    try {
      final uri = Uri.parse(value);
      if (!uri.hasScheme || (!uri.scheme.startsWith('http'))) {
        return _getLocalizedMessage('url_invalid', locale);
      }
      return null;
    } catch (e) {
      return _getLocalizedMessage('url_invalid', locale);
    }
  }

  /// Validate ISBN (both ISBN-10 and ISBN-13)
  static String? validateISBN(String? value, {String? locale}) {
    if (value == null || value.isEmpty) {
      return _getLocalizedMessage('isbn_required', locale);
    }

    final cleaned = value.replaceAll(RegExp(r'[^\dX]'), '');

    if (cleaned.length == 10) {
      if (!_isValidISBN10(cleaned)) {
        return _getLocalizedMessage('isbn_invalid', locale);
      }
    } else if (cleaned.length == 13) {
      if (!_isValidISBN13(cleaned)) {
        return _getLocalizedMessage('isbn_invalid', locale);
      }
    } else {
      return _getLocalizedMessage('isbn_invalid', locale);
    }

    return null;
  }

  /// Validate credit card number (Luhn algorithm)
  static String? validateCreditCard(String? value, {String? locale}) {
    if (value == null || value.isEmpty) {
      return _getLocalizedMessage('credit_card_required', locale);
    }

    final cleaned = value.replaceAll(RegExp(r'[^\d]'), '');

    if (cleaned.length < 13 || cleaned.length > 19) {
      return _getLocalizedMessage('credit_card_invalid', locale);
    }

    if (!_luhnCheck(cleaned)) {
      return _getLocalizedMessage('credit_card_invalid', locale);
    }

    return null;
  }

  /// Validate book title
  static String? validateBookTitle(String? value, {String? locale}) {
    if (value == null || value.isEmpty) {
      return _getLocalizedMessage('book_title_required', locale);
    }

    if (value.trim().length < 1) {
      return _getLocalizedMessage('book_title_required', locale);
    }

    if (value.length > 200) {
      return _getLocalizedMessage('book_title_max_length', locale);
    }

    return null;
  }

  /// Validate author name
  static String? validateAuthorName(String? value, {String? locale}) {
    if (value == null || value.isEmpty) {
      return _getLocalizedMessage('author_required', locale);
    }

    if (value.trim().length < 2) {
      return _getLocalizedMessage('author_min_length', locale);
    }

    if (value.length > 100) {
      return _getLocalizedMessage('author_max_length', locale);
    }

    return null;
  }

  /// Validate reading progress (0-100%)
  static String? validateReadingProgress(String? value, {String? locale}) {
    if (value == null || value.isEmpty) return null;

    final progress = double.tryParse(value);
    if (progress == null) {
      return _getLocalizedMessage('progress_invalid', locale);
    }

    if (progress < 0 || progress > 100) {
      return _getLocalizedMessage('progress_range', locale);
    }

    return null;
  }

  /// Helper method to get localized error messages
  static String _getLocalizedMessage(String key, String? locale,
      [int? number, String? field]) {
    final isTurkish = (locale ?? 'tr_TR').startsWith('tr');

    switch (key) {
      case 'email_required':
        return isTurkish ? 'E-posta adresi gereklidir' : 'Email is required';
      case 'email_invalid':
        return isTurkish
            ? 'Geçerli bir e-posta adresi girin'
            : 'Enter a valid email address';
      case 'password_required':
        return isTurkish ? 'Şifre gereklidir' : 'Password is required';
      case 'password_min_length':
        return isTurkish
            ? 'Şifre en az $number karakter olmalıdır'
            : 'Password must be at least $number characters';
      case 'password_uppercase':
        return isTurkish
            ? 'Şifre en az bir büyük harf içermelidir'
            : 'Password must contain at least one uppercase letter';
      case 'password_lowercase':
        return isTurkish
            ? 'Şifre en az bir küçük harf içermelidir'
            : 'Password must contain at least one lowercase letter';
      case 'password_numbers':
        return isTurkish
            ? 'Şifre en az bir rakam içermelidir'
            : 'Password must contain at least one number';
      case 'password_special_chars':
        return isTurkish
            ? 'Şifre en az bir özel karakter içermelidir'
            : 'Password must contain at least one special character';
      case 'password_confirmation_required':
        return isTurkish
            ? 'Şifre onayı gereklidir'
            : 'Password confirmation is required';
      case 'password_mismatch':
        return isTurkish ? 'Şifreler eşleşmiyor' : 'Passwords do not match';
      case 'phone_required':
        return isTurkish
            ? 'Telefon numarası gereklidir'
            : 'Phone number is required';
      case 'phone_invalid':
        return isTurkish
            ? 'Geçerli bir telefon numarası girin'
            : 'Enter a valid phone number';
      case 'id_required':
        return isTurkish
            ? 'Kimlik numarası gereklidir'
            : 'ID number is required';
      case 'id_length':
        return isTurkish
            ? 'Kimlik numarası 11 haneli olmalıdır'
            : 'ID number must be 11 digits';
      case 'id_invalid':
        return isTurkish ? 'Geçersiz kimlik numarası' : 'Invalid ID number';
      case 'name_required':
        return isTurkish ? 'İsim gereklidir' : 'Name is required';
      case 'name_min_length':
        return isTurkish
            ? 'İsim en az $number karakter olmalıdır'
            : 'Name must be at least $number characters';
      case 'name_max_length':
        return isTurkish
            ? 'İsim en fazla $number karakter olabilir'
            : 'Name cannot exceed $number characters';
      case 'name_invalid':
        return isTurkish
            ? 'İsim sadece harf içerebilir'
            : 'Name can only contain letters';
      case 'field_required':
        return isTurkish
            ? '${field ?? "Bu alan"} gereklidir'
            : '${field ?? "This field"} is required';
      case 'field_min_length':
        return isTurkish
            ? '${field ?? "Bu alan"} en az $number karakter olmalıdır'
            : '${field ?? "This field"} must be at least $number characters';
      case 'field_max_length':
        return isTurkish
            ? '${field ?? "Bu alan"} en fazla $number karakter olabilir'
            : '${field ?? "This field"} cannot exceed $number characters';
      case 'numeric_required':
        return isTurkish
            ? 'Sayısal değer gereklidir'
            : 'Numeric value is required';
      case 'numeric_invalid':
        return isTurkish ? 'Geçerli bir sayı girin' : 'Enter a valid number';
      case 'numeric_min':
        return isTurkish
            ? 'Değer en az $number olmalıdır'
            : 'Value must be at least $number';
      case 'numeric_max':
        return isTurkish
            ? 'Değer en fazla $number olabilir'
            : 'Value cannot exceed $number';
      case 'date_required':
        return isTurkish ? 'Tarih gereklidir' : 'Date is required';
      case 'date_invalid':
        return isTurkish ? 'Geçerli bir tarih girin' : 'Enter a valid date';
      case 'date_min':
        return isTurkish ? 'Tarih çok erken' : 'Date is too early';
      case 'date_max':
        return isTurkish ? 'Tarih çok geç' : 'Date is too late';
      case 'age_required':
        return isTurkish ? 'Yaş gereklidir' : 'Age is required';
      case 'age_invalid':
        return isTurkish ? 'Geçerli bir yaş girin' : 'Enter a valid age';
      case 'age_range':
        return isTurkish
            ? 'Yaş $number ile $field arasında olmalıdır'
            : 'Age must be between $number and $field';
      case 'url_required':
        return isTurkish ? 'URL gereklidir' : 'URL is required';
      case 'url_invalid':
        return isTurkish ? 'Geçerli bir URL girin' : 'Enter a valid URL';
      case 'isbn_required':
        return isTurkish ? 'ISBN gereklidir' : 'ISBN is required';
      case 'isbn_invalid':
        return isTurkish ? 'Geçersiz ISBN' : 'Invalid ISBN';
      case 'credit_card_required':
        return isTurkish
            ? 'Kredi kartı numarası gereklidir'
            : 'Credit card number is required';
      case 'credit_card_invalid':
        return isTurkish
            ? 'Geçersiz kredi kartı numarası'
            : 'Invalid credit card number';
      case 'book_title_required':
        return isTurkish
            ? 'Kitap başlığı gereklidir'
            : 'Book title is required';
      case 'book_title_max_length':
        return isTurkish ? 'Kitap başlığı çok uzun' : 'Book title is too long';
      case 'author_required':
        return isTurkish ? 'Yazar ismi gereklidir' : 'Author name is required';
      case 'author_min_length':
        return isTurkish ? 'Yazar ismi çok kısa' : 'Author name is too short';
      case 'author_max_length':
        return isTurkish ? 'Yazar ismi çok uzun' : 'Author name is too long';
      case 'progress_invalid':
        return isTurkish
            ? 'Geçersiz ilerleme değeri'
            : 'Invalid progress value';
      case 'progress_range':
        return isTurkish
            ? 'İlerleme 0-100 arasında olmalıdır'
            : 'Progress must be between 0-100';
      default:
        return isTurkish ? 'Geçersiz değer' : 'Invalid value';
    }
  }

  /// Helper method for ISBN-10 validation
  static bool _isValidISBN10(String isbn) {
    int sum = 0;
    for (int i = 0; i < 9; i++) {
      sum += int.parse(isbn[i]) * (10 - i);
    }

    final lastChar = isbn[9];
    final checkDigit = lastChar == 'X' ? 10 : int.parse(lastChar);
    sum += checkDigit;

    return sum % 11 == 0;
  }

  /// Helper method for ISBN-13 validation
  static bool _isValidISBN13(String isbn) {
    int sum = 0;
    for (int i = 0; i < 12; i++) {
      final digit = int.parse(isbn[i]);
      sum += (i % 2 == 0) ? digit : digit * 3;
    }

    final checkDigit = (10 - (sum % 10)) % 10;
    return checkDigit == int.parse(isbn[12]);
  }

  /// Helper method for Luhn algorithm (credit card validation)
  static bool _luhnCheck(String cardNumber) {
    int sum = 0;
    bool isEven = false;

    for (int i = cardNumber.length - 1; i >= 0; i--) {
      int digit = int.parse(cardNumber[i]);

      if (isEven) {
        digit *= 2;
        if (digit > 9) {
          digit = digit % 10 + digit ~/ 10;
        }
      }

      sum += digit;
      isEven = !isEven;
    }

    return sum % 10 == 0;
  }
}
