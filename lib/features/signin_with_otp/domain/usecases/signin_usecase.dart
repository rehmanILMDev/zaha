import 'package:dartz/dartz.dart';
import 'package:zaha/features/signin_with_otp/domain/repositories/auth_repo.dart';
import '../../../../core/error/failures.dart';

class LoginWithPhoneNumber extends UseCase<void, Params> {
  final AuthRepository repository;

  LoginWithPhoneNumber(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.loginWithPhoneNumber(params.phoneNumber, params.codeSent);
  }

  verifyOtp(String verificationId, String otp) {}
}

class Params {
  final String phoneNumber;
  final Function(String) codeSent;

  Params({required this.phoneNumber, required this.codeSent});
}
