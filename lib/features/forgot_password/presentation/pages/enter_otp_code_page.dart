import 'package:flutter/material.dart';

import '../../../../core/shared/colors.dart';
import '../widgets/enter_otp_code_form.dart';
import '../widgets/form_container.dart';
import '../widgets/header.dart';
import '../widgets/otp_header_message.dart';

class EnterOTPCodePage extends StatefulWidget {
  static const pageRoute = '/otpScreen';
  final String email;
  const EnterOTPCodePage({Key? key, required this.email}) : super(key: key);

  @override
  _EnterOTPCodePageState createState() => _EnterOTPCodePageState();
}

class _EnterOTPCodePageState extends State<EnterOTPCodePage> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight * 0.2,
            ),
            Header(
              labelText: 'Enter OTP',
            ),
            SizedBox(
              height: screenHeight * 0.018,
            ),
            Expanded(
              child: FormContainer(
                form: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
                  child: Column(
                    children: [
                      OTPHeaderMessage(
                        email: "${widget.email}",
                      ),
                      EnterOTPCodeForm(email: widget.email),
                      SizedBox(
                        height: screenHeight * 0.07,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
