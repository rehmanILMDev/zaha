
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaha/features/on_broad_feat/domain/usecases/get_onboarding_data.dart';
import 'package:zaha/features/on_broad_feat/presentation/bloc/on_broad_event.dart';
import 'package:zaha/features/on_broad_feat/presentation/bloc/on_broad_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final GetOnboardingData getOnboardingData;

  OnboardingBloc({required this.getOnboardingData}) : super(OnboardingInitial()) {
    on<LoadOnboardingData>(_onLoadOnboardingData);
  }

  Future<void> _onLoadOnboardingData(
      LoadOnboardingData event, Emitter<OnboardingState> emit) async {
    emit(OnboardingLoading());
    try {
      final onboardingData = await getOnboardingData();
      emit(OnboardingLoaded(onboardingData));
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }
}
