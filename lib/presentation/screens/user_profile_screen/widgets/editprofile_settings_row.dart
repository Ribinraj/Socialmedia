import 'package:flutter/material.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';
import 'package:social_media_app/presentation/screens/editprofile/screen_editprofile.dart';
import 'package:social_media_app/presentation/screens/settings/screen_settings.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:social_media_app/presentation/widgets/custom_profile_button.dart';

class EditAndSettingsRow extends StatelessWidget {
  const EditAndSettingsRow({
    super.key, required this.state1,
  });
  final LoginUserSuccessState state1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomProfilebutton(
                onPressed: () {
                  navigatePush(
                      context,
                      SreenProfileEdit(
                        loginuser: state1.loginuserdata,
                      ));
                },
                buttonText: 'Edit Profile'),
            kwidth20,
            CustomProfilebutton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScreenSettings(),
                    ),
                  );
                },
                buttonText: 'Settings')
          ],
        ),
      ],
    );
  }
}
