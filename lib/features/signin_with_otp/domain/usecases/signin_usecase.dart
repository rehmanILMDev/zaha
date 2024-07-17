
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zaha/features/signin_with_otp/data/repositories/auth_repo.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase({required this.repository});

  Future<void> signIn(String phoneNumber, Function(PhoneAuthCredential) verificationCompleted, Function(FirebaseAuthException) verificationFailed, Function(String, int?) codeSent, Function(String) codeAutoRetrievalTimeout) async {
    return repository.signInWithPhoneNumber(phoneNumber, verificationCompleted, verificationFailed, codeSent, codeAutoRetrievalTimeout);
  }

  Future<UserCredential> verifyOTP(String verificationId, String smsCode) async {
    return repository.verifyOTP(verificationId, smsCode);
  }
}
