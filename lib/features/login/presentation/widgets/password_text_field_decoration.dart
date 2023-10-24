import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/constants.dart';

class PasswordTextFieldDecoration extends StatefulWidget {
  @override
  State<PasswordTextFieldDecoration> createState() =>
      _PasswordTextFieldDecorationState();
}

class _PasswordTextFieldDecorationState
    extends State<PasswordTextFieldDecoration> {
  late bool _passwordVisible;
  final TextEditingController pass = new TextEditingController();

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight(context) * 0.08,
      child: TextFormField(
          obscureText: !_passwordVisible,
          decoration: kTextFieldDecoration(context).copyWith(
            hintText: 'Enter your password',
            suffix: IconButton(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          onChanged: (value) {
            //todo
          }),
    );
  }
}
