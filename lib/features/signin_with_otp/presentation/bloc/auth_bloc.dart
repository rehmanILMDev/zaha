import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zaha/features/signin_with_otp/domain/usecases/signin_usecase.dart';
import 'package:zaha/features/signin_with_otp/domain/usecases/verify_otp_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithPhoneNumber signInWithPhoneNumber;
  final VerifyOtp verifyOtp;

  AuthBloc({
    required this.signInWithPhoneNumber,
    required this.verifyOtp,
  }) : super(AuthInitial()) {
    on<PhoneNumberSubmitted>(_onPhoneNumberSubmitted);
    on<OtpSubmitted>(_onOtpSubmitted);
  }

  void _onPhoneNumberSubmitted(PhoneNumberSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await signInWithPhoneNumber(event.phoneNumber);
      emit(AuthCodeSent());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onOtpSubmitted(OtpSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await verifyOtp(event.otp);
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
