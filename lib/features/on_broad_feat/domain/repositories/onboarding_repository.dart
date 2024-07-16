import 'package:zaha/features/on_broad_feat/domain/entities/onbroading_entity.dart';

abstract class OnboardingRepository {
  Future<List<Onboarding>> getOnboardingData();
}