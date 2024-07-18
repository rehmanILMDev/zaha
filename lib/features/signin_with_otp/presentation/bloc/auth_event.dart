part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginWithPhoneNumberEvent extends AuthEvent {
  final String phoneNumber;
  final Function(String) codeSent;

  LoginWithPhoneNumberEvent({required this.phoneNumber, required this.codeSent});

  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOtpEvent extends AuthEvent {
  final String verificationId;
  final String otp;

  VerifyOtpEvent({required this.verificationId, required this.otp});

  @override
  List<Object> get props => [verificationId, otp];
}
