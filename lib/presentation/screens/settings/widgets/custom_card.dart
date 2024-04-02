import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class CustomSettingsCard extends StatelessWidget {
  final VoidCallback onpress;
  final IconData icon;
  final String text;
  const CustomSettingsCard({
    super.key,
    required this.onpress,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      child: Container(
        width: size.width,
        height: 60,
        decoration:
            BoxDecoration(color: kpurplelightColor, borderRadius: kradius10),
        child: Row(children: [
          kwidth,
          Icon(icon),
          kwidth,
          customHeadingtext(text, 20, textColor: kblackColor),
          const Spacer(),
          IconButton(
              onPressed: onpress,
              icon: const Icon(Icons.arrow_circle_right_outlined))
        ]),
      ),
    );
  }
}
