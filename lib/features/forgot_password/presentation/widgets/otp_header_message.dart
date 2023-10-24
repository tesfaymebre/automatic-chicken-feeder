import 'package:flutter/material.dart';

import '../../../../core/shared/colors.dart';

class OTPHeaderMessage extends StatelessWidget {
  const OTPHeaderMessage({Key? key, this.email}) : super(key: key);

  final email;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: TextStyle(
            color: grey_medium,
            fontFamily: "Poppins Regular",
            fontSize: MediaQuery.of(context).size.width * 0.028,
          ),
          children: [
            TextSpan(text: "Please enter the 6 digit code we sent you to "),
            TextSpan(
              text: email as String,
              style: TextStyle(
                fontFamily: "Poppins SemiBold",
                fontSize: MediaQuery.of(context).size.width * 0.028,
              ),
            ),
            TextSpan(text: " to reset your password.")
          ]),
    );
  }
}
