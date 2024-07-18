import 'package:dartz/dartz.dart';
import 'package:zaha/core/error/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> loginWithPhoneNumber(String phoneNumber, Function(String) codeSent);
  Future<Either<Failure, void>> verifyOtp(String verificationId, String smsCode);
}
