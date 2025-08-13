part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class Login extends LoginEvent {
  final String user;
  final String pass;
  final String pushToken;

  Login({
    required this.user,
    required this.pass,
    required this.pushToken,
  });
}

class ObscureText extends LoginEvent {}