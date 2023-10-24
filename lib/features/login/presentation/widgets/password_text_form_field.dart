import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/constants.dart';
import '../../../../core/validators/input_validators.dart';
import '../bloc/login_bloc.dart';

class PasswordTextFormField extends StatefulWidget {
  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  late bool _passwordVisible;
  final TextEditingController pass = new TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // obscureText: !_passwordVisible,
      obscureText: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFF7F8F8),
        prefixIcon: Icon(Icons.lock),
        hintText: 'Enter your password',
        hintStyle: const TextStyle(
            fontFamily: 'Poppins', fontSize: 12, color: Color(0xFF5C5354)),
        contentPadding: EdgeInsets.only(
          top: screenHeight(context) * 15.63,
          bottom: screenHeight(context) * 16.38,
          left: screenWidth(context) * 16.5,
        ),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(screenHeight(context) * 14)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffF7F8F8), width: 1.0),
          borderRadius:
              BorderRadius.all(Radius.circular(screenHeight(context) * 5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffF7F8F8), width: 2.0),
          borderRadius:
              BorderRadius.all(Radius.circular(screenHeight(context) * 14)),
        ),
      ),
      onChanged: (value) {
        context.read<LoginBloc>().add(LoginPasswordChanged(value));
      },
      validator: (value) {
        var message = Validators.validatePassword(value);

        if (message != null) {
          return message;
        } else {
          return null;
        }
      },
    );
  }
}
