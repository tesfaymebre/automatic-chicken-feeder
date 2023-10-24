import 'package:chicken_feeder/core/shared/constants.dart';
import 'package:chicken_feeder/features/forgot_password/presentation/widgets/flutter_otp_text_field.dart';
import 'package:chicken_feeder/features/forgot_password/presentation/widgets/resend_otp_request.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/colors.dart';
import '../bloc/forgot_password_bloc.dart';
import '../pages/resetPassword.dart';

class EnterOTPCodeForm extends StatefulWidget {
  final String email;
  const EnterOTPCodeForm({Key? key, required this.email}) : super(key: key);

  @override
  _EnterOTPCodeFormState createState() => _EnterOTPCodeFormState();
}

class _EnterOTPCodeFormState extends State<EnterOTPCodeForm> {
  final _formKey = GlobalKey<FormState>();
  String enteredOTPCode = "";

  void _handleFormSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(enteredOTPCode);
      BlocProvider.of<ForgotPasswordBloc>(context).add(
          SubmitVerificationCodeEvent(
              otpCode: enteredOTPCode, email: widget.email));
    }
  }

  Widget build(BuildContext context) {
    var height = screenHeight(context);
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.050,
            ),
            OtpTextField(
              numberOfFields: 6,

              fieldWidth: screenWidth(context) * 0.11,
              margin: EdgeInsets.all(7),
              filled: true,
              fillColor: background_dark_light,
              //set to true to show as box or false to show as dash
              showFieldAsBox: true,
              focusedBorderColor: border_color,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderWidth: 2.0,
              decoration: InputDecoration(contentPadding: EdgeInsets.all(20)),

              onSubmit: (String verificationCode) {
                enteredOTPCode = verificationCode;
              },
            ),
            SizedBox(
              height: height * 0.050,
            ),
            ResendOTPRequest(
              email: widget.email,
            ),
            SizedBox(
              height: height * 0.05,
            ),
            BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) {
                if (state is CodeVerifiedState) {
                  Navigator.of(context).pushNamed(
                    ResetForgotPasswordPage.resetpageRoute,
                    arguments: state.otpCode,
                  );
                } else if (state is IncorrectCodeSentState) {
                  ScaffoldMessenger.of(context)
                    ..clearSnackBars()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(
                          'An error occured. Try again.',
                        ),
                      ),
                    );
                }
              },
              builder: (context, state) {
                if (state is LoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return MaterialButton(
                  child: Text(
                    "verify",
                    style: TextStyle(
                      fontFamily: 'Poppins Medium',
                      fontSize: height * 0.027,
                      color: Colors.white,
                    ),
                  ),
                  minWidth: double.infinity,
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: height * 0.015),
                  onPressed: _handleFormSubmit,
                  color: primary,
                  shape: StadiumBorder(
                      side: BorderSide(color: border, width: 0.0)),
                );
              },
            ),
          ],
        ));
  }
}
