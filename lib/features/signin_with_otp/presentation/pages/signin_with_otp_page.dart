import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaha/core/routes/routes_name.dart';
import 'package:zaha/features/signin_with_otp/presentation/bloc/auth_bloc.dart';

class SignInOtpPage extends StatelessWidget {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  SignInOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushNamed(context, RoutesName.homeScreen);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        PhoneNumberSubmitted(_phoneNumberController.text),
                      );
                },
                child: Text('Send OTP'),
              ),
              TextField(
                controller: _otpController,
                decoration: InputDecoration(labelText: 'OTP'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        OtpSubmitted(_otpController.text),
                      );
                },
                child: Text('Verify OTP'),
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return CircularProgressIndicator();
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
