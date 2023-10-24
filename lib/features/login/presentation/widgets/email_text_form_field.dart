import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/constants.dart';
import '../../../../core/validators/input_validators.dart';
import '../bloc/login_bloc.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        context.read<LoginBloc>().add(LoginEmailChanged(value));
      },
      decoration: kTextFieldDecoration(context).copyWith(
        prefixIcon: Icon(Icons.email_outlined),
        hintText: 'Email',
      ),
      validator: (value) {
        var message = Validators.validateEmail(value);
        if (message != null) {
          return message;
        } else {
          return null;
        }
      },
    );
  }
}
