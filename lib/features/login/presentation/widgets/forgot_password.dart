import 'package:chicken_feeder/core/shared/constants.dart';
import 'package:flutter/material.dart';

import '../../../forgot_password/presentation/pages/forgotPassword.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: screenWidth(context) * 0.0772),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              // Navigator.pushNamed(context, ForgotPasswordPage.forgotpageRoute);
            },
            child: const Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
