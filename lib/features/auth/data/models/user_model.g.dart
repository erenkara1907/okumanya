// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      lastName: json['last_name'] as String?,
      email: json['email'] as String,
      userLevel: (json['user_level'] as num).toInt(),
      userRole: json['user_role'] as String,
      phoneNumber: json['phone_number'] as String?,
      schoolId: (json['school_id'] as num?)?.toInt(),
      branchId: (json['branch_id'] as num?)?.toInt(),
      address: json['address'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'last_name': instance.lastName,
      'email': instance.email,
      'user_level': instance.userLevel,
      'user_role': instance.userRole,
      'phone_number': instance.phoneNumber,
      'school_id': instance.schoolId,
      'branch_id': instance.branchId,
      'address': instance.address,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
