import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';

Widget titlelogo() {
  return RichText(
    text: const TextSpan(
      children: [
        TextSpan(
            text: 'interac',
            style: TextStyle(
              color: kwhiteColor,
              fontSize: 27,
              fontWeight: FontWeight.w600,
            )),
        TextSpan(
          text: 't',
          style: TextStyle(
            color: kwhiteColor,
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
