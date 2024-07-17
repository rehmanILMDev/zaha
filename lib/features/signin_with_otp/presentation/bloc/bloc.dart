import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaha/features/signin_with_otp/domain/usecases/signin_usecase.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;

  SignInBloc({required this.signInUseCase}) : super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SendOtpEvent) {
      yield* _mapSendOtpToState(event);
    } else if (event is VerifyOtpEvent) {
      yield* _mapVerifyOtpToState(event);
    }
  }

  Stream<SignInState> _mapSendOtpToState(SendOtpEvent event) async* {
    yield SignInLoading();
    await signInUseCase.signIn(
      event.phoneNumber,
      (credential) {},
      (exception) {
        add(SignInFailedEvent(exception.message ?? 'Verification failed'));
      },
      (verificationId, resendToken) {
        add(OtpSentEvent(verificationId));
      },
      (verificationId) {},
    );
  }

  Stream<SignInState> _mapVerifyOtpToState(VerifyOtpEvent event) async* {
    yield SignInLoading();
    try {
      await signInUseCase.verifyOTP(event.verificationId, event.otp);
      yield SignInSuccess();
    } catch (e) {
      yield SignInFailed(e.toString());
    }
  }
}

abstract class SignInEvent {}

class SendOtpEvent extends SignInEvent {
  final String phoneNumber;

  SendOtpEvent(this.phoneNumber);
}

class VerifyOtpEvent extends SignInEvent {
  final String verificationId;
  final String otp;

  VerifyOtpEvent(this.verificationId, this.otp);
}

class OtpSentEvent extends SignInEvent {
  final String verificationId;

  OtpSentEvent(this.verificationId);
}

class SignInFailedEvent extends SignInEvent {
  final String error;

  SignInFailedEvent(this.error);
}

abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class OtpSent extends SignInState {
  final String verificationId;

  OtpSent(this.verificationId);
}

class SignInSuccess extends SignInState {}

class SignInFailed extends SignInState {
  final String error;

  SignInFailed(this.error);
}
