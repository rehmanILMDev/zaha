import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaha/features/signin_with_otp/presentation/bloc/bloc.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is SignInFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: SignInForm(),
      ),
    );
  }
}

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String _verificationId = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Phone Number'),
            keyboardType: TextInputType.phone,
          ),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<SignInBloc>(context).add(
                SendOtpEvent(_phoneController.text),
              );
            },
            child: Text('Send OTP'),
          ),
          TextField(
            controller: _otpController,
            decoration: InputDecoration(labelText: 'OTP'),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: () {
              BlocProvider.of<SignInBloc>(context).add(
                VerifyOtpEvent(_verificationId, _otpController.text),
              );
            },
            child: Text('Verify OTP'),
          ),
        ],
      ),
    );
  }
}
