import 'package:flutter/material.dart';

import '../widgets/emailForm.dart';
import '../widgets/forgot_password_text.dart';
import '../widgets/loginTop.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  static const forgotpageRoute = '/forgot';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF8F8FF),
        body: SafeArea(
            child: ListView(children: [
          Container(
              child: Column(
            children: [
              // the logo in the top
              // Logo(),
              // the login image
              LoginTop(),
              // the forgot password text
              ForgotPasswordText(),
              Container(
                padding: EdgeInsets.fromLTRB(40, 5, 35, 10),
                // the text in forgot password page
                child: Text(
                  "Don't worry it happens. Please enter the email address associated with your account",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 19,
                    color: Color(0xFF535461),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(40, 15, 35, 10),
                // the email form
                child: EmailForm(),
              )
            ],
          ))
        ])));
  }
}
