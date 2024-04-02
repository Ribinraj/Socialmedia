import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';

class CustomSigninButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const CustomSigninButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 67,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: kradius10,
            ),
            backgroundColor: kpurpleColor,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(color: kwhiteColor, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
