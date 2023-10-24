import 'package:flutter/material.dart';

class LoginTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // image that is visible at the top of login page below the logo
    return Container(
      padding: EdgeInsets.fromLTRB(40, 5, 35, 10),
      height: screenHeight * 0.233,
      child: Image(
        image: AssetImage('assets/forgot.png'),
      ),
    );
  }
}
