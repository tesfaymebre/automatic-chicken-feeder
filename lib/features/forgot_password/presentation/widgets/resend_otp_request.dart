import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/colors.dart';
import '../bloc/forgot_password_bloc.dart';

class ResendOTPRequest extends StatelessWidget {
  final String email;
  const ResendOTPRequest({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Container(
        margin: EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 0.0),
        child: Text(
          'Did not receive the code?',
          style: TextStyle(fontSize: 18, fontFamily: 'Poppins Regular'),
        ),
      ),
      Container(
        child: TextButton(
          // if resend button clicked resend the verification code
          onPressed: () {
            BlocProvider.of<ForgotPasswordBloc>(context).add(
              ResubmitEmailEvent(email: email),
            );
          },
          child: const Text(
            'Resend',
            style: TextStyle(color: text_color),
          ),

          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 16,
              fontFamily: 'poppins',
            ),
          ),
        ),
      )
    ]);
  }
}
