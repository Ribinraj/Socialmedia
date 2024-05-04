import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/presentation/screens/main_page/screen_main_page.dart';
import 'package:social_media_app/presentation/screens/signin/screen_signin.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

void showAlertDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: customHeadingtext('Logout', 25, textColor: kblackColor),
    content: const Text("Are you sure you want to logout?"),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Cancel"),
      ),
      TextButton(
        onPressed: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool('LOGIN', false);
          // ignore: use_build_context_synchronously
          navigatePushandRemoveuntil(context, const ScreenSignIn());
             currentPage.value = 0;
        },
        child: const Text("OK"),
      ),
    ],
  );

  // Show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
