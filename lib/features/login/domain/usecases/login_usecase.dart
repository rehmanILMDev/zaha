import 'package:dartz/dartz.dart' as dartz;
import 'package:zaha/core/error/failures.dart';
import 'package:zaha/features/login/domain/entities/login_entity.dart';
import 'package:zaha/features/login/domain/repositories/login_repo.dart';

class LoginUsecase {
  final LoginRepository repository;

  LoginUsecase(this.repository);

  Future<dartz.Either<Failure, void>> call(Login login) async {
    return await repository.loginReq(login);
  }
}
