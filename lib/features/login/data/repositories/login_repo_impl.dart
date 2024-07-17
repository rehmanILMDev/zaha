import 'package:dartz/dartz.dart';
import 'package:zaha/core/error/failures.dart';
import 'package:zaha/features/login/data/datasources/login_remote_data_source.dart';
import 'package:zaha/features/login/data/models/login_model.dart';
import 'package:zaha/features/login/domain/entities/login_entity.dart';
import 'package:zaha/features/login/domain/repositories/login_repo.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;

  LoginRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> loginReq(Login login) async {
    try {
      final loginModel = LoginModel(
        email: login.email,
        password: login.password,
      );
      await remoteDataSource.loginReq(loginModel);
      return const Right(null);
    } catch (e, stacktrace) {
      // Use a logging framework instead of print in production
      print('Error while login: $e');
      print(stacktrace);
      return Left(ServerFailure());
    }
  }
}

extension on LoginModel {
  Login toDomain() {
    return Login(
      email: email,
      password: password,
    );
  }
}
