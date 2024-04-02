import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/widgets/custom_signin_button.dart';
import 'package:social_media_app/presentation/widgets/custom_textfield.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenForgotPassword extends StatefulWidget {
  const ScreenForgotPassword({super.key});

  @override
  State<ScreenForgotPassword> createState() => _ScreenForgotPassword();
}

class _ScreenForgotPassword extends State<ScreenForgotPassword> {
  final emailController = TextEditingController();
  final phonenumberController = TextEditingController();
  final enterotpController = TextEditingController();
  final newpasswordController = TextEditingController();
  final conformpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kpurplelightColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: 300,
              decoration: const BoxDecoration(
                  color: kpurpleMediumColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Center(child: customHeadingtext('Forgot Password', 30)),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 200),
                width: size.width * .8,
                height: 550,
                decoration:
                    BoxDecoration(color: kwhiteColor, borderRadius: kradius20),
                child: Column(
                  children: [
                    kheight30,
                    CustomTextfield(
                        controller: emailController,
                        labelText: 'EmailAdress',
                        textInputType: TextInputType.name),
                    CustomSigninButton(
                        onPressed: () {}, buttonText: 'Send Otp'),
                    kheight,
                    CustomTextfield(
                        controller: enterotpController,
                        labelText: 'Enter otp',
                        textInputType: TextInputType.number),
                    kheight,
                    CustomTextfield(
                        controller: newpasswordController,
                        labelText: 'New Password',
                        textInputType: TextInputType.visiblePassword),
                    kheight,
                    CustomTextfield(
                        controller: conformpasswordController,
                        labelText: 'Conform Password',
                        textInputType: TextInputType.visiblePassword),
                    CustomSigninButton(onPressed: () {}, buttonText: 'Reset'),
                    GestureDetector(
                        onTap: () {}, child: const Text('Have an Account?'))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
