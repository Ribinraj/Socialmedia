import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/editprofile/edit_profile_bloc.dart';
import 'package:social_media_app/presentation/screens/editprofile/screen_editprofile.dart';
import 'package:social_media_app/presentation/widgets/custom_signin_button.dart';
import 'package:social_media_app/presentation/widgets/custom_textfield.dart';

class BackgroundImageSection extends StatelessWidget {
  const BackgroundImageSection({
    super.key,
    required this.namecontroller,
    required this.biocontroller,
    required this.image,
    required this.editProfilebloc,
    required this.backgroundimage,
    required this.widget,
  });

  final TextEditingController namecontroller;
  final TextEditingController biocontroller;
  final File? image;
  final EditProfileBloc editProfilebloc;
  final File? backgroundimage;
  final SreenProfileEdit widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 200.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        height: 500,
        decoration: BoxDecoration(
          color: kpurplelightColor,
          borderRadius: kradius30,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            CustomTextfield(
                controller: namecontroller,
                labelText: 'Name'),
            CustomTextfield(
                controller: biocontroller, labelText: 'Bio'),
            CustomSigninButton(
                onPressed: () {
                  debugPrint('file:$image.toString()');
                  editProfilebloc.add(EditprofileClickEvent(
                      name: namecontroller.text,
                      bio: biocontroller.text,
                      image: image,
                      backgroundImage: backgroundimage,
                      backgroundImageurl:
                          widget.loginuser.backGroundImage,
                      imageurl: widget.loginuser.profilePic));
                },
                buttonText: 'Update')
          ],
        ),
      ),
    );
  }
}
