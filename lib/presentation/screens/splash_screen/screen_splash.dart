import 'package:flutter/material.dart';

import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/presentation/screens/main_page/screen_main_page.dart';
import 'package:social_media_app/presentation/screens/signin/screen_signin.dart';

import 'package:social_media_app/presentation/widgets/tex.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kpurpleColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: customHeadingtext('Junction', 50,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  Future<void> checkUserLogin(context) async {
    final preferences = await SharedPreferences.getInstance();
    final userLoggedIn = preferences.get('LOGIN');
    if (userLoggedIn == null || userLoggedIn == false) {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const ScreenSignIn(),
      ));
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => SCreenmainpage(),
      ));
    }
  }
}
