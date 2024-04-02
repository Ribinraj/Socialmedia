import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';

class CustomProfilebutton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const CustomProfilebutton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 150,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                  bottomRight: Radius.circular(10)),
            ),
            backgroundColor: kpurpleColor,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(color: kwhiteColor, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
