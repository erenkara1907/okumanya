import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String name,
    @JsonKey(name: 'last_name') String? lastName,
    required String email,
    @JsonKey(name: 'user_level') required int userLevel,
    @JsonKey(name: 'user_role') required String userRole,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'school_id') int? schoolId,
    @JsonKey(name: 'branch_id') int? branchId,
    String? address,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'deleted_at') String? deletedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
