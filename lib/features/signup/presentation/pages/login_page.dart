import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
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
  final _nationalIdFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();

  final _nationalIdController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isNationalIdValid = true;
  bool _isPhoneValid = true;

  bool _nationalIdTouched = false;
  bool _phoneTouched = false;

  @override
  void initState() {
    super.initState();
    _nationalIdFocusNode.addListener(() {
      if (!_nationalIdFocusNode.hasFocus) {
        setState(() {
          _nationalIdTouched = true;
          _isNationalIdValid = _validateNationalId();
        });
      }
    });
    _phoneFocusNode.addListener(() {
      if (!_phoneFocusNode.hasFocus) {
        setState(() {
          _phoneTouched = true;
          _isPhoneValid = _validatePhone();
        });
      }
    });
  }

  @override
  void dispose() {
    _nationalIdFocusNode.dispose();
    _phoneFocusNode.dispose();
    _nationalIdController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool _validateNationalId() {
    final value = _nationalIdController.text;
    final lengthValidator = ValidationBuilder().minLength(5).maxLength(20).build();
    final lengthError = lengthValidator(value);
    final numberError = _validateNumber(value, 'National ID');
    return lengthError == null && numberError == null;
  }

  bool _validatePhone() {
    final value = _phoneController.text;
    final lengthValidator = ValidationBuilder().minLength(10).maxLength(10).build();
    final lengthError = lengthValidator(value);
    final numberError = _validateNumber(value, 'phone number');
    return lengthError == null && numberError == null;
  }

  String? _validateNumber(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid $fieldName';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.green),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Center(
              child: Text(
                'Back',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => sl<LoginBloc>(),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lets start with your credentials',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'You will use this as your login',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _nationalIdController,
                      focusNode: _nationalIdFocusNode,
                      onChanged: (value) {
                        context.read<LoginBloc>().add(LoginIdChanged(value));
                        if (_nationalIdTouched) {
                          setState(() {
                            _isNationalIdValid = _validateNationalId();
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'National ID',
                        hintText: 'Enter National ID',
                        border: OutlineInputBorder(),
                        errorText: !_isNationalIdValid ? 'Please enter a valid National ID' : null,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      onChanged: (value) {
                        context.read<LoginBloc>().add(LoginPhoneChanged(value));
                        if (_phoneTouched) {
                          setState(() {
                            _isPhoneValid = _validatePhone();
                          });
                        }
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: 'Enter Your Number',
                        border: OutlineInputBorder(),
                        errorText: !_isPhoneValid ? 'Please enter a valid phone number' : null,
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: state.isValid
                            ? () {
                                setState(() {
                                  _nationalIdTouched = true;
                                  _phoneTouched = true;
                                });
                                if (_formKey.currentState?.validate() ?? false) {
                                  context.read<LoginBloc>().add(LoginSubmitted());
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
