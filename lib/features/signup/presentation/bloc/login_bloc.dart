
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaha/features/login/presentation/bloc/login_event.dart';
import 'package:zaha/features/login/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState.initial()) {
    on<LoginIdChanged>((event, emit) {
      emit(state.copyWith(id: event.id, isValid: event.id.isNotEmpty && state.phone.isNotEmpty));
    });
    on<LoginPhoneChanged>((event, emit) {
      emit(state.copyWith(phone: event.phone, isValid: state.id.isNotEmpty && event.phone.isNotEmpty));
    });
    on<LoginSubmitted>((event, emit) {
      // For demonstration purposes, print the data to the console
      if (kDebugMode) {
        print('ID: ${state.id}, Phone: ${state.phone}');
      }
    });
  }
}
