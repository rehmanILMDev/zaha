// login_state.dart

import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final String id;
  final String phone;
  final bool isValid;

  LoginState({required this.id, required this.phone, required this.isValid});

  factory LoginState.initial() {
    return LoginState(id: '', phone: '', isValid: false);
  }

  LoginState copyWith({
    String? id,
    String? phone,
    bool? isValid,
  }) {
    return LoginState(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [id, phone, isValid];
}
