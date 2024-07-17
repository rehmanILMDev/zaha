import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String email;
  final String password;
  final bool isValid;
  final bool isSubmitting;
  final String? errorMessage;
  final bool loginSuccess;

  const LoginState({
    required this.email,
    required this.password,
    required this.isValid,
    required this.isSubmitting,
    this.errorMessage,
    required this.loginSuccess,
  });

  factory LoginState.initial() {
    return const LoginState(
      email: '',
      password: '',
      isValid: false,
      isSubmitting: false,
      errorMessage: null,
      loginSuccess: false,
    );
  }

  LoginState copyWith({
    String? email,
    String? password,
    bool? isValid,
    bool? isSubmitting,
    String? errorMessage,
    bool? loginSuccess,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      loginSuccess: loginSuccess ?? this.loginSuccess,
    );
  }

  @override
  List<Object?> get props => [email, password, isValid, isSubmitting, errorMessage, loginSuccess];
}

class LoginInitial extends LoginState {
  const LoginInitial({
    required super.email,
    required super.password,
    required super.isValid,
    required super.isSubmitting,
    super.errorMessage,
    required super.loginSuccess,
  });
}
