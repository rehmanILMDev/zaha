import 'package:dartz/dartz.dart' as dartz;
import 'package:zaha/core/error/failures.dart';
import 'package:zaha/features/login/domain/entities/login_entity.dart';

abstract class LoginRepository {
  Future<dartz.Either<Failure, void>> loginReq(Login login);
}
