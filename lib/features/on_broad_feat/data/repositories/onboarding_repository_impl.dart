
import 'package:zaha/features/on_broad_feat/data/datasources/onboarding_local_data_source.dart';
import 'package:zaha/features/on_broad_feat/domain/entities/onbroading_entity.dart';
import 'package:zaha/features/on_broad_feat/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Onboarding>> getOnboardingData() async {
    return await localDataSource.getOnboardingData();
  }
}
