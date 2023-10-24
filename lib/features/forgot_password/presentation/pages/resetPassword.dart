import 'package:flutter/material.dart';

import '../../../../core/shared/colors.dart';
import '../widgets/loginTop.dart';
import '../widgets/passwordForm.dart';
import '../widgets/reset_password_text.dart';

class ResetForgotPasswordPage extends StatelessWidget {
  final String otpCode;
  const ResetForgotPasswordPage({
    Key? key,
    required this.otpCode,
  }) : super(key: key);

  static const resetpageRoute = '/reset_password';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        body: SafeArea(
            child: ListView(children: [
          Container(
              //height: 1000,
              child: Column(
            children: [
              LoginTop(),
              ResetPasswordText(),
              Container(
                padding: EdgeInsets.fromLTRB(40, 15, 35, 10),
                child: PasswordForm(otpCode: otpCode),
              )
            ],
          ))
        ])));
  }
}
