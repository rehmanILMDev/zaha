
import 'package:zaha/features/signin_with_otp/data/repositories/auth_repo_impl.dart';

class VerifyOtp {
  final AuthRepository repository;

  VerifyOtp(this.repository);

  Future<void> call(String otp) {
    return repository.verifyOtp(otp);
  }
}
