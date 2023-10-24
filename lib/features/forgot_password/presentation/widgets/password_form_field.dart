import 'package:chicken_feeder/features/forgot_password/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared/colors.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField(
      {Key? key,
      required this.hintText,
      this.validator,
      required this.controller,
      this.onChanged})
      : super(key: key);

  final String hintText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          validator: widget.validator,
          onChanged: widget.onChanged,
          obscureText: _obscureText,
          controller: widget.controller,
          decoration: InputDecoration(
              filled: true,
              fillColor: fill_color,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(screenHeight * 0.019),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(screenHeight * 0.019),
                borderSide: BorderSide(color: border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(screenHeight * 0.019),
                borderSide: BorderSide(
                  color: border_color,
                  width: 2.0,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                  vertical: 0, horizontal: screenHeight * 0.019),
              hintText: widget.hintText,
              hintStyle: TextStyle(color: text_color),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              )),
          style: TextStyle(
            fontSize: screenHeight * 0.0205,
            fontFamily: 'Poppins Regular',
          ),
        ),
      ],
    );
  }
}
