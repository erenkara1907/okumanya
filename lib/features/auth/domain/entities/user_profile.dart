import 'package:freezed_annotation/freezed_annotation.dart';

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
    final names = fullName.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return names.isNotEmpty ? names[0][0].toUpperCase() : '?';
  }
}
