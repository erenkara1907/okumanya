import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/utils/date_utils.dart';
import '../../../../core/utils/string_extensions.dart';
import '../../../../core/utils/validation_utils.dart';

part 'user_profile.freezed.dart';

/// Domain entity for user profile following Single Responsibility Principle
/// Represents only the profile-related user data, separate from authentication
@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String fullName,
    required String email,
    String? phoneNumber,
    String? avatarUrl,
    String? bio,
    DateTime? birthDate,
    String? location,
    @Default('en') String preferredLanguage,
    @Default(true) bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserProfile;

  const UserProfile._();

  /// Business logic method - gets display name
  String get displayName {
    return fullName.isNotEmpty ? fullName : email.split('@').first;
  }

  /// Business logic method - checks if profile is complete
  bool get isProfileComplete {
    return fullName.isNotEmpty &&
        email.isNotEmpty &&
        phoneNumber != null &&
        avatarUrl != null;
  }

  /// Business logic method - gets initials for avatar
  String get initials {
    return fullName.getInitials();
  }

  /// Get user age from birth date
  int? get age {
    return birthDate?.ageFromBirthDate;
  }

  /// Get formatted birth date
  String? formattedBirthDate({String? locale}) {
    return birthDate?.toFormattedDate(locale: locale);
  }

  /// Get member since date
  String memberSince({String? locale}) {
    return createdAt.toFormattedDate(locale: locale);
  }

  /// Get how long user has been a member
  String memberDuration({String? locale}) {
    return createdAt.toRelativeTime(locale: locale);
  }

  /// Get formatted full name with proper case
  String get formattedFullName {
    return fullName.toCapitalCase();
  }

  /// Get masked phone number for display
  String? get maskedPhoneNumber {
    return phoneNumber?.mask(visibleStart: 3, visibleEnd: 2);
  }

  /// Validate if profile data is valid
  String? validateEmail({String? locale}) {
    return ValidationUtils.validateEmail(email, locale: locale);
  }

  String? validatePhoneNumber({String? locale}) {
    return ValidationUtils.validateTurkishPhone(phoneNumber, locale: locale);
  }

  String? validateFullName({String? locale}) {
    return ValidationUtils.validateName(fullName, locale: locale);
  }

  /// Check if user was created today
  bool get isNewUser {
    return createdAt.isToday;
  }

  /// Check if user profile was updated recently (within last 7 days)
  bool get wasRecentlyUpdated {
    return updatedAt.isThisWeek;
  }

  /// Get user's search-friendly name
  String get searchableName {
    return fullName.toSearchFormat();
  }

  /// Get bio preview for cards
  String? get shortBio {
    return bio?.truncateAtWord(50);
  }
}
