// login_state.dart


part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final String id;
  final String phone;
  final bool isValid;

  SignupState({required this.id, required this.phone, required this.isValid});

  factory SignupState.initial() {
    return SignupState(id: '', phone: '', isValid: false);
  }

  SignupState copyWith({
    String? id,
    String? phone,
    bool? isValid,
  }) {
    return SignupState(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [id, phone, isValid];
}
