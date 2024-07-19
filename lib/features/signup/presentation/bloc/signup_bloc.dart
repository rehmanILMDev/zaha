
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState.initial()) {
    on<SignupIdChanged>((event, emit) {
      emit(state.copyWith(id: event.id, isValid: event.id.isNotEmpty && state.phone.isNotEmpty));
    });
    on<SignupPhoneChanged>((event, emit) {
      emit(state.copyWith(phone: event.phone, isValid: state.id.isNotEmpty && event.phone.isNotEmpty));
    });
    on<SignupSubmitted>((event, emit) {
      // For demonstration purposes, print the data to the console
      if (kDebugMode) {
        print('ID: ${state.id}, Phone: ${state.phone}');
      }
    });
  }
}
