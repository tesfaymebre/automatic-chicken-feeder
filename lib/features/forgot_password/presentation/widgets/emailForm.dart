import 'package:chicken_feeder/core/shared/constants.dart';
import 'package:chicken_feeder/features/forgot_password/presentation/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/colors.dart';
import '../../../../core/validators/input_validators.dart';
import '../bloc/forgot_password_bloc.dart';
import '../pages/enter_otp_code_page.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({Key? key}) : super(key: key);

  @override
  EmailFormState createState() => EmailFormState();
}

class EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>();
  String email = "";

  void _handleFormSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      BlocProvider.of<ForgotPasswordBloc>(context).add(
        SubmitEmailEvent(email: email),
      );
    }
  }

  Widget build(BuildContext context) {
    var height = screenHeight(context);
    // the email form used in forgot password page
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomFormField(
              hintText: 'username@example.com',
              inputType: TextInputType.emailAddress,
              validator: Validators.validateEmail,
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: height * 0.05,
            ),
            BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) {
                // if the email verification is successful go to the enter otp code page
                if (state is EmailSentState) {
                  Navigator.pushNamed(
                    context,
                    EnterOTPCodePage.pageRoute,
                    arguments: state.email,
                  );
                } else if (state is EmailNotSentState) {
                  // if the email is not verified show the eoor message
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
                      "Submit",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: height * 0.027,
                        color: text_color_white,
                      ),
                    ),
                    minWidth: double.infinity,
                    elevation: 0.0,
                    padding: EdgeInsets.symmetric(vertical: height * 0.015),
                    onPressed: _handleFormSubmit,
                    color: Color.fromRGBO(102, 102, 163, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0)));
              },
            ),
          ],
        ));
  }
}
