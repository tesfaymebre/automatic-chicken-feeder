import 'package:flutter/material.dart';

class ResetPasswordText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(40, 20, 35, 2),
            //margin: EdgeInsets.fromLTRB(20, 20, 0, 10),
            child: const Text(
              'Reset',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            )),
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(40, 3, 35, 20),
            //margin: EdgeInsets.fromLTRB(20, 20, 0, 10),
            child: const Text(
              'Password',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
