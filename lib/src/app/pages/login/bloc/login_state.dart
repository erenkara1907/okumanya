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
  LoginState({
    this.status = LoginStatus.initial,
    UserModel? userModel,
    ProfileModel? profileModel,
    String? user,
    String? pass,
    bool? obscure,
    String? errorMessage,
  })  : userModel = userModel ?? UserModel(),
        profileModel = profileModel ?? ProfileModel(),
        user = user ?? '',
        pass = pass ?? '',
        obscure = obscure == true,
        errorMessage = errorMessage ?? '';

  final LoginStatus status;
  final UserModel userModel;
  final ProfileModel profileModel;
  final String user;
  final String pass;
  final bool obscure;
  final String errorMessage;

  @override
  List<Object?> get props => [
        status,
        userModel,
        profileModel,
        user,
        pass,
        obscure,
        errorMessage,
      ];

  LoginState copyWith({
    LoginStatus? status,
    UserModel? userModel,
    ProfileModel? profileModel,
    String? user,
    String? pass,
    bool? obscure,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      userModel: userModel ?? this.userModel,
      profileModel: profileModel ?? this.profileModel,
      user: user ?? this.user,
      pass: pass ?? this.pass,
      obscure: obscure ?? this.obscure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}