import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';

class LoginEntity extends Equatable {
  final String token;
  final bool isTeacher;
  final UserModel user;

  const LoginEntity({
    required this.token,
    required this.isTeacher,
    required this.user,
  });

  @override
  List<Object> get props => [token, isTeacher, user];
}
