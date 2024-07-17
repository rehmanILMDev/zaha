import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zaha/features/signin_with_otp/data/repositories/auth_repo.dart';
import 'package:zaha/features/signin_with_otp/domain/usecases/signin_usecase.dart';
import 'package:zaha/features/signin_with_otp/presentation/bloc/bloc.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  // Register the repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(firebaseAuth: sl()));

  // Register the use case
  sl.registerLazySingleton(() => SignInUseCase(repository: sl()));

  // Register the BLoC
  sl.registerFactory(() => SignInBloc(signInUseCase: sl()));
}
