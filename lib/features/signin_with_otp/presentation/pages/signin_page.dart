import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zaha/features/home/presentation/pages/home_page.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String? verificationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Phone Number'),
      ),
      body: BlocProvider(
        create: (context) => BlocProvider.of<AuthBloc>(context),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthCodeSent) {
              verificationId = state.verificationId;
            } else if (state is AuthVerified) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: 'Phone Number'),
                    ),
                    SizedBox(height: 20),
                    if (verificationId != null) ...[
                      TextField(
                        controller: _otpController,
                        decoration: InputDecoration(labelText: 'OTP'),
                      ),
                      SizedBox(height: 20),
                    ],
                    ElevatedButton(
                      onPressed: () {
                        if (verificationId == null) {
                          BlocProvider.of<AuthBloc>(context).add(LoginWithPhoneNumberEvent(
                            phoneNumber: _phoneController.text,
                            codeSent: (String verificationId) {
                              setState(() {
                                this.verificationId = verificationId;
                              });
                            },
                          ));
                        } else {
                          BlocProvider.of<AuthBloc>(context).add(VerifyOtpEvent(
                            verificationId: verificationId!,
                            otp: _otpController.text,
                          ));
                        }
                      },
                      child: Text(verificationId == null ? 'Send OTP' : 'Verify OTP'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
