import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:zaha/core/routes/routes_name.dart';
import 'package:zaha/features/login/presentation/bloc/login_bloc.dart';
import 'package:zaha/features/login/presentation/bloc/login_event.dart';
import 'package:zaha/features/login/presentation/bloc/login_state.dart';
import 'package:zaha/injection_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isEmailValid = true;
  bool _isPasswordValid = true;

  bool _validateEmail() {
    final value = _emailController.text;
    final emailValidator = ValidationBuilder().email().build();
    final emailError = emailValidator(value);
    return emailError == null;
  }

  bool _validatePassword() {
    final value = _passwordController.text;
    final passwordValidator = ValidationBuilder()
        .regExp(
            RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,15}$'),
            "Enter a strong password")
        .build();
    final passwordError = passwordValidator(value);
    return passwordError == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<LoginBloc>(),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage!), 
                duration:Duration(milliseconds: 500),
                 backgroundColor: Colors.green,),
              );
            } else if (state.isSubmitting) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logging in...'),
                duration:Duration(milliseconds: 500),
                backgroundColor: Colors.green,),
              );
            } else if (state.loginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login successful'),
                duration:Duration(milliseconds: 500),
                 backgroundColor: Colors.green,),
              );
              Navigator.pushNamed(context, RoutesName.homeScreen);  
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back! Sign in to continue',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please Enter your registered credentials.',
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (current, previous) =>
                        current.email != previous.email,
                    builder: (context, state) {
                      return TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        onChanged: (value) {
                          context
                              .read<LoginBloc>()
                              .add(LoginEmailChanged(value));
                        },
                          validator: ValidationBuilder().email().maxLength(50).build(),

                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter email ID',
                          border: const OutlineInputBorder(),
                          errorText: !_isEmailValid
                              ? 'Please enter a valid Email ID'
                              : null,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<LoginBloc, LoginState>(
                    buildWhen: (current, previous) =>
                        current.password != previous.password,
                    builder: (context, state) {
                      return TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        onChanged: (value) {
                          context
                              .read<LoginBloc>()
                              .add(LoginPasswordChanged(value));
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Your Password',
                          border: const OutlineInputBorder(),
                          errorText: !_isPasswordValid
                              ? 'Please enter a valid Password'
                              : null,
                        ),
                        obscureText: true,
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: state.isValid
                              ? () {
                                  BlocProvider.of<LoginBloc>(context)
                                      .add(LoginSubmitted());
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
