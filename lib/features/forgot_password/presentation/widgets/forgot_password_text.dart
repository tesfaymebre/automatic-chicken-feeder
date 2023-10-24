import 'package:flutter/material.dart';

class ForgotPasswordText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // forgot password text
    return Column(
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(40, 20, 35, 2),
            child: const Text(
              'Forgot',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            )),
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(40, 3, 35, 20),
            child: const Text(
              'Password ?',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ))
      ],
    );
  }
}
