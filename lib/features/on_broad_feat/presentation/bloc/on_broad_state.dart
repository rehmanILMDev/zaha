
import 'package:zaha/features/on_broad_feat/domain/entities/onbroading_entity.dart';

abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingLoaded extends OnboardingState {
  final List<Onboarding> onboardingData;

  OnboardingLoaded(this.onboardingData);
}

class OnboardingError extends OnboardingState {
  final String message;

  OnboardingError(this.message);
}
