
import 'package:zaha/features/signin_with_otp/data/repositories/auth_repo_impl.dart';

class SignInWithPhoneNumber {
  final AuthRepository repository;

  SignInWithPhoneNumber(this.repository);

  Future<void> call(String phoneNumber) {
    return repository.signInWithPhoneNumber(phoneNumber);
  }
}
