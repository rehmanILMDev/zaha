import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zaha/features/signin_with_otp/domain/repositories/auth_repo.dart';
import '../datasources/auth_remote_data_source.dart';
import '../../../../core/error/failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> loginWithPhoneNumber(String phoneNumber, Function(String) codeSent) async {
    try {
      await remoteDataSource.loginWithPhoneNumber(phoneNumber, codeSent);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp(String verificationId, String smsCode) async {
    try {
      await remoteDataSource.verifyOtp(verificationId, smsCode);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
