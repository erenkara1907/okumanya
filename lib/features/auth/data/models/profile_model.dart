import 'package:hive_flutter/adapters.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 1)
class ProfileModel {
  @HiveField(0)
  User? user;
  @HiveField(1)
  Detail? detail;
  @HiveField(2)
  String? submituri;
  @HiveField(3)
  String? sitetitle;
  @HiveField(4)
  String? currenturi;

  ProfileModel(
      {this.user,
      this.detail,
      this.submituri,
      this.sitetitle,
      this.currenturi});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    detail = json['detail'] != null ? Detail.fromJson(json['detail']) : null;
    submituri = json['submituri'];
    sitetitle = json['sitetitle'];
    currenturi = json['currenturi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (detail != null) {
      data['detail'] = detail!.toJson();
    }
    data['submituri'] = submituri;
    data['sitetitle'] = sitetitle;
    data['currenturi'] = currenturi;
    return data;
  }
}

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? photo;

  User({this.id, this.name, this.photo});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    return data;
  }
}

@HiveType(typeId: 3)
class Detail {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? fullname;
  @HiveField(2)
  String? pushtoken;
  @HiveField(3)
  String? lastLogin;
  @HiveField(4)
  String? role;

  Detail({this.id, this.fullname, this.pushtoken, this.lastLogin, this.role});

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    pushtoken = json['pushtoken'];
    lastLogin = json['last_login'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['pushtoken'] = pushtoken;
    data['last_login'] = lastLogin;
    data['role'] = role;
    return data;
  }
}