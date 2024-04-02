import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/screens/settings/widgets/custom_alertbox.dart';
import 'package:social_media_app/presentation/screens/settings/widgets/custom_card.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenSettings extends StatefulWidget {
  const ScreenSettings({super.key});

  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kpurpleColor,
      appBar: AppBar(
        title: customHeadingtext('Settings', 20),
        centerTitle: true,
        backgroundColor: kpurpleColor,
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          color: kwhiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          children: [
            kheight50,
            CustomSettingsCard(
              icon: Icons.notifications,
              onpress: () {},
              text: 'Notifications',
            ),
            kheight20,
            CustomSettingsCard(
                onpress: () {},
                icon: Icons.offline_bolt_rounded,
                text: 'Offline'),
            kheight20,
            CustomSettingsCard(
                onpress: () {},
                icon: Icons.privacy_tip_rounded,
                text: 'Set as Private'),
            kheight20,
            CustomSettingsCard(
                onpress: () {},
                icon: Icons.privacy_tip_outlined,
                text: 'Privacy & Policy'),
            kheight20,
            CustomSettingsCard(
                onpress: () {}, icon: Icons.details, text: 'About us'),
            kheight20,
            CustomSettingsCard(
                onpress: () {
                  showAlertDialog(context);
                },
                icon: Icons.logout_sharp,
                text: 'Logout')
          ],
        ),
      ),
    );
  }
}
