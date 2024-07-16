import 'package:get_it/get_it.dart';
import 'package:zaha/features/login/presentation/bloc/login_bloc.dart';
import 'package:zaha/features/on_broad_feat/data/datasources/onboarding_local_data_source.dart';
import 'package:zaha/features/on_broad_feat/data/repositories/onboarding_repository_impl.dart';
import 'package:zaha/features/on_broad_feat/domain/repositories/onboarding_repository.dart';
import 'package:zaha/features/on_broad_feat/domain/usecases/get_onboarding_data.dart';
import 'package:zaha/features/on_broad_feat/presentation/bloc/on_broad_bloc.dart';
final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => OnboardingBloc(getOnboardingData: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetOnboardingData(sl()));

  // Repository
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(),
  );
  // for login
   sl.registerFactory(() => LoginBloc());

}
