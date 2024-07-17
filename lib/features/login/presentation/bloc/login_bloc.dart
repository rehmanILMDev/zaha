import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaha/features/login/domain/usecases/login_usecase.dart';
import 'package:zaha/features/login/domain/entities/login_entity.dart';
import 'package:zaha/features/login/presentation/bloc/login_event.dart';
import 'package:zaha/features/login/presentation/bloc/login_state.dart';
import 'package:zaha/core/error/failures.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;

  LoginBloc({required this.loginUsecase}) : super(LoginState.initial()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(
        email: event.email,
        isValid: event.email.isNotEmpty && state.password.isNotEmpty,
        isSubmitting: false,
        errorMessage: null,
        loginSuccess: false,
      ));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(
        password: event.password,
        isValid: state.email.isNotEmpty && event.password.isNotEmpty,
        isSubmitting: false,
        errorMessage: null,
        loginSuccess: false,
      ));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, errorMessage: null, loginSuccess: false));

      final failureOrSuccess = await loginUsecase.call(Login(
        email: state.email,
        password: state.password,
      ));

      failureOrSuccess.fold(
        (failure) {
          emit(state.copyWith(
            isSubmitting: false,
            errorMessage: _mapFailureToMessage(failure),
            loginSuccess: false,
          ));
          if (kDebugMode) {
            print('Login failed: ${_mapFailureToMessage(failure)}');
          }
        },
        (_) {
          emit(state.copyWith(isSubmitting: false, errorMessage: null, loginSuccess: true));
          if (kDebugMode) {
            print('Login successful');
          }
        },
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
