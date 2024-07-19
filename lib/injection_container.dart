// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:zaha/core/network/network_info.dart';
// import 'package:zaha/features/login/data/datasources/login_remote_data_source.dart';
// import 'package:zaha/features/login/data/repositories/login_repo_impl.dart';
// import 'package:zaha/features/login/domain/repositories/login_repo.dart';
// import 'package:zaha/features/login/domain/usecases/login_usecase.dart';
// import 'package:zaha/features/login/presentation/bloc/login_bloc.dart';
// import 'package:zaha/features/on_broad_feat/data/datasources/onboarding_local_data_source.dart';
// import 'package:zaha/features/on_broad_feat/data/repositories/onboarding_repository_impl.dart';
// import 'package:zaha/features/on_broad_feat/domain/repositories/onboarding_repository.dart';
// import 'package:zaha/features/on_broad_feat/domain/usecases/get_onboarding_data.dart';
// import 'package:zaha/features/on_broad_feat/presentation/bloc/on_broad_bloc.dart';

// final sl = GetIt.instance;

// Future<void> init() async {
//   // Bloc
//   sl.registerFactory(() => OnboardingBloc(getOnboardingData: sl()));

//   // Use cases
//   sl.registerLazySingleton(() => GetOnboardingData(sl()));

//   // Repository
//   sl.registerLazySingleton<OnboardingRepository>(
//     () => OnboardingRepositoryImpl(localDataSource: sl()),
//   );

//   // Data sources
//   sl.registerLazySingleton<OnboardingLocalDataSource>(
//     () => OnboardingLocalDataSourceImpl(),
//   );
//   // for login
//   // Bloc
//   sl.registerFactory(
//     () => LoginBloc(
//       loginUsecase: sl(),
//     ),
//   );

//   // Use cases
//   sl.registerLazySingleton(() => LoginUsecase(sl()));

//   // Repository
//   sl.registerLazySingleton<LoginRepository>(
//     () => LoginRepositoryImpl(
//       remoteDataSource: sl(),
//     ),
//   );

//   // Data sources
//   sl.registerLazySingleton<LoginRemoteDataSource>(
//       () => LoginRemoteDataSource(client: sl()));

//   // Register Dio
//   sl.registerLazySingleton(() => Dio());
// }



import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:zaha/features/login/data/datasources/login_remote_data_source.dart';
import 'package:zaha/features/login/data/repositories/login_repo_impl.dart';
import 'package:zaha/features/login/domain/repositories/login_repo.dart';
import 'package:zaha/features/login/domain/usecases/login_usecase.dart';
import 'package:zaha/features/login/presentation/bloc/login_bloc.dart';
import 'package:zaha/features/on_broad_feat/data/datasources/onboarding_local_data_source.dart';
import 'package:zaha/features/on_broad_feat/data/repositories/onboarding_repository_impl.dart';
import 'package:zaha/features/on_broad_feat/domain/repositories/onboarding_repository.dart';
import 'package:zaha/features/on_broad_feat/domain/usecases/get_onboarding_data.dart';
import 'package:zaha/features/on_broad_feat/presentation/bloc/on_broad_bloc.dart';
import 'package:zaha/features/signin_with_otp/data/repositories/auth_repo_impl.dart';
import 'package:zaha/features/signin_with_otp/domain/usecases/signin_usecase.dart';
import 'package:zaha/features/signin_with_otp/domain/usecases/verify_otp_usecase.dart';
import 'package:zaha/features/signin_with_otp/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Onboarding feature dependencies
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

  // Login feature dependencies
  // Bloc
  sl.registerFactory(
    () => LoginBloc(
      loginUsecase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUsecase(sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSource(client: sl()));

  // // SignIn with OTP feature dependencies
   // Firebase
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => SignInWithPhoneNumber(sl()));
  sl.registerLazySingleton(() => VerifyOtp(sl()));

  // BLoC
  sl.registerFactory(() => AuthBloc(
        signInWithPhoneNumber: sl(),
        verifyOtp: sl(),
      ));
}
