import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zaha/features/signin_with_otp/domain/usecases/signin_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginWithPhoneNumber loginWithPhoneNumber;

  AuthBloc({required this.loginWithPhoneNumber}) : super(AuthInitial()) {
    on<LoginWithPhoneNumberEvent>((event, emit) async {
      emit(AuthLoading());
      final failureOrSuccess = await loginWithPhoneNumber(
        Params(
          phoneNumber: event.phoneNumber,
          codeSent: event.codeSent,
        ),
      );
      failureOrSuccess.fold(
        (failure) => emit(AuthError(message: 'Failed to login')),
        (success) => emit(AuthCodeSent(verificationId: event.phoneNumber)), // Adjust this to actual verificationId
      );
    });

    on<VerifyOtpEvent>((event, emit) async {
      emit(AuthLoading());
      final failureOrSuccess = await loginWithPhoneNumber.verifyOtp(
        event.verificationId,
        event.otp,
      );
      failureOrSuccess.fold(
        (failure) => emit(AuthError(message: 'Failed to verify OTP')),
        (success) => emit(AuthVerified()),
      );
    });
  }
}
