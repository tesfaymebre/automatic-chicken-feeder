import 'package:chicken_feeder/core/shared/constants.dart';
import 'package:chicken_feeder/features/forgot_password/presentation/widgets/password_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/colors.dart';
import '../../../../core/validators/input_validators.dart';
import '../../../login/presentation/pages/login_screen.dart';
import '../bloc/forgot_password_bloc.dart';

class PasswordForm extends StatefulWidget {
  final String otpCode;
  const PasswordForm({Key? key, required this.otpCode}) : super(key: key);

  @override
  PasswordFormState createState() => PasswordFormState();
}

class PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String confirmPassword = '';
  String newPassword = '';
  TextEditingController password = TextEditingController();
  TextEditingController conpassword = TextEditingController();
  void _handleFormSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // if the form is valid and submitted trigger submit new password event with the new password and the token
      BlocProvider.of<ForgotPasswordBloc>(context).add(
        SubmitNewPasswordEvent(
          newPassword: newPassword,
          otpCode: widget.otpCode,
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    var height = screenHeight(context);
    return Form(
        key: _formKey,
        child: Column(
          children: [
            PasswordFormField(
              hintText: 'New Password',
              controller: password,
              validator: Validators.validatePassword,
              onChanged: (value) {
                newPassword = value;
              },
            ),
            SizedBox(
              height: height * 0.05,
            ),
            PasswordFormField(
              hintText: 'Confirm Password',
              controller: conpassword,
              //validates the field
              validator: (String? value) {
                if (value?.length == 0) {
                  return 'Please re-enter password';
                }
                RegExp regExp = RegExp(
                    r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{6,}$");
                if (!regExp.hasMatch(conpassword.text)) {
                  return "Password must be at least 6 characters and can only contain a number and a letter.";
                }

                if (password.text != conpassword.text) {
                  return "Password does not match";
                }
              },
              onChanged: (value) {
                confirmPassword = value;
              },
            ),
            SizedBox(
              height: height * 0.05,
            ),
            BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) {
                // if change password is successfull navigate to login page
                if (state is SuccessfullyChangedPasswordState) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
                // if it is not successfull show error
                else if (state is UpdateForgottenPasswordErrorState) {
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
                    color: primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0)));
              },
            ),
          ],
        ));
  }
}
