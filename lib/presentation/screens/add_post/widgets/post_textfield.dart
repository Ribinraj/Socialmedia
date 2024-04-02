import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';

class PostTextfield extends StatelessWidget {
  const PostTextfield({
    super.key,
    required this.controller,
    required this.labelText,
  });

  final TextEditingController controller;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        maxLines: 3,
        controller: controller,
        style: const TextStyle(fontSize: 15),
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          hintText: labelText,
          hintStyle: const TextStyle(
              color: kpurpleColor, fontWeight: FontWeight.w300, fontSize: 16),
          enabledBorder: OutlineInputBorder(
              borderRadius: kradius10,
              borderSide:
                  const BorderSide(color: kpurpleBorderColor, width: 1.5)),
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
              borderSide: const BorderSide(color: kgreycolor, width: 1.5)),
        ),
      ),
    );
  }
}
