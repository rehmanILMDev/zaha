// login_event.dart

import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginIdChanged extends LoginEvent {
  final String id;

  LoginIdChanged(this.id);

  @override
  List<Object> get props => [id];
}

class LoginPhoneChanged extends LoginEvent {
  final String phone;

  LoginPhoneChanged(this.phone);

  @override
  List<Object> get props => [phone];
}

class LoginSubmitted extends LoginEvent {}
