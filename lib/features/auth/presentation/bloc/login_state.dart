part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, error, notfound }

extension LoginStatusX on LoginStatus {
  bool get isInitial => this == LoginStatus.initial;
  bool get isLoading => this == LoginStatus.loading;
  bool get isSuccess => this == LoginStatus.success;
  bool get isError => this == LoginStatus.error;
  bool get isNotFound => this == LoginStatus.notfound;
}

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.loginEntity,
    this.email = '',
    this.password = '',
    this.obscure = true,
    this.errorMessage = '',
  });

  final LoginStatus status;
  final LoginEntity? loginEntity;
  final String email;
  final String password;
  final bool obscure;
  final String errorMessage;

  @override
  List<Object?> get props => [
        status,
        loginEntity,
        email,
        password,
        obscure,
        errorMessage,
      ];

  LoginState copyWith({
    LoginStatus? status,
    LoginEntity? loginEntity,
    String? email,
    String? password,
    bool? obscure,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      loginEntity: loginEntity ?? this.loginEntity,
      email: email ?? this.email,
      password: password ?? this.password,
      obscure: obscure ?? this.obscure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}