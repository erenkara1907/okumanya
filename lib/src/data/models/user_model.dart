import 'package:hive_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  bool? success;
  @HiveField(1)
  String? token;
  @HiveField(2)
  String? id;
  @HiveField(3)
  String? message;

  UserModel({this.success, this.token, this.id, this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    id = json['id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['token'] = token;
    data['id'] = id;
    data['message'] = message;
    return data;
  }
}
