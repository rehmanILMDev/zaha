
import 'package:zaha/features/on_broad_feat/domain/entities/onbroading_entity.dart';
import 'package:zaha/features/on_broad_feat/domain/repositories/onboarding_repository.dart';

class GetOnboardingData {
  final OnboardingRepository repository;

  GetOnboardingData(this.repository);

  Future<List<Onboarding>> call() async {
    return await repository.getOnboardingData();
  }
}
