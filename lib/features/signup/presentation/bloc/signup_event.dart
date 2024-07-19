// login_event.dart


part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignupIdChanged extends SignupEvent {
  final String id;

  SignupIdChanged(this.id);

  @override
  List<Object> get props => [id];
}

class SignupPhoneChanged extends SignupEvent {
  final String phone;

  SignupPhoneChanged(this.phone);

  @override
  List<Object> get props => [phone];
}

class SignupSubmitted extends SignupEvent {}
