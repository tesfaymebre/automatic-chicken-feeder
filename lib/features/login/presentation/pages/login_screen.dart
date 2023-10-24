import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../core/shared/constants.dart';
import '../../../../core/shared/failure_snackbar_diplay.dart';
import '../bloc/login_bloc.dart';
import '../widgets/email_text_form_field.dart';
import '../widgets/forgot_password.dart';
import '../widgets/password_text_form_field.dart';
import '../widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: screenWidth(context) * 40),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: screenHeight(context) * 400,
                    child: Image.asset('assets/images/login.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight(context) * 1),
                    child: const Text(
                      'Login with',
                      style: TextStyle(
                        fontFamily: 'SF Pro Text Bold',
                        fontSize: 24,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight(context) * 32,
                  ),
                  EmailTextFormField(),
                  SizedBox(
                    height: screenHeight(context) * 26,
                  ),
                  PasswordTextFormField(),
                  SizedBox(
                    height: screenHeight(context) * 0.0223,
                  ),
                  ForgotPassword(),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     top: screenHeight(context) * 52,
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       GestureDetector(
                  //         onTap: () {
                  //           //todo navigation
                  //         },
                  //         child: const Text(
                  //           'Forgot Password?',
                  //           style: TextStyle(
                  //             color: Color(0xFF3242D5),
                  //             fontFamily: "Poppins Regular",
                  //             fontSize: 15,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: fullScreenHeight(context) * 0.18,
                  ),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state.status == FormzStatus.submissionFailure) {
                        final snackBar =
                            FailureSnackbarDisplay("Failed to login");
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      } else if (state.status ==
                          FormzStatus.submissionSuccess) {
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          width: fullScreenWidth(context),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RoundedButton(
                                sideImage: Image.asset(
                                  "assets/images/logo.png",
                                  height: 27,
                                ),
                                title: 'Log in',
                                color: const Color(0xFF3B4CA6),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<LoginBloc>()
                                        .add(const LoginSubmitted());
                                  }

                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (_) => HiddenDrawer()));
                                  //todo Implement login functionality.
                                },
                              ),
                              SizedBox(
                                height: screenHeight(context) * 22,
                              ),
                              if (state.status ==
                                  FormzStatus.submissionInProgress)
                                const Center(child: CircularProgressIndicator())
                            ],
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

  void showsnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
