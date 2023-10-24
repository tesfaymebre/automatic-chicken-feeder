import 'package:chicken_feeder/features/forgot_password/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {Key? key,
      required this.hintText,
      this.validator,
      this.onChanged,
      this.inputType = TextInputType.text,
      this.initialValue})
      : super(key: key);

  final String hintText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType inputType;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          validator: validator,
          keyboardType: inputType,
          onChanged: onChanged,
          initialValue: initialValue,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFF1F3FC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Color(0xFFDFE1E8)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: Color(0XFF3F3D56),
                width: 2.0,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15.0),
            hintText: hintText,
            hintStyle: TextStyle(color: Color(0xFF6666A3)),
          ),
          style: TextStyle(
            fontSize: screenHeight * 0.021,
            fontFamily: 'Poppins Regular',
          ),
        ),
      ],
    );
  }
}
