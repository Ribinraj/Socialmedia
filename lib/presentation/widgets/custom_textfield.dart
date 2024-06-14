import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    this.textInputType,
    this.validator,
    this.suffixIcon,
    this.obscureText,
  });

  final TextEditingController controller;
  final String labelText;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText ?? false,
        keyboardType: textInputType,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
            isDense: true,
            errorMaxLines: 3,
            suffixIcon: suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            labelText: labelText,
            labelStyle: const TextStyle(
                color: kpurpleColor, fontWeight: FontWeight.w300, fontSize: 16),
            enabledBorder: OutlineInputBorder(
                borderRadius: kradius10,
                borderSide:
                    const BorderSide(color: kpurpleMediumColor, width: 1.5)),
            focusedBorder: OutlineInputBorder(
                borderRadius: kradius10,
                borderSide:
                    const BorderSide(color: kpurplelightColor, width: 1.5)),
            errorBorder: OutlineInputBorder(
              borderRadius: kradius10,
              borderSide: const BorderSide(color: kgreycolor, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: kradius10,
                borderSide: const BorderSide(color: kgreycolor, width: 1.5))),
      ),
    );
  }
}
