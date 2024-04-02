import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/login/login_bloc.dart';
import 'package:social_media_app/presentation/screens/forgotPassword/screen_forgotpassword.dart';
import 'package:social_media_app/presentation/screens/main_page/screen_main_page.dart';

import 'package:social_media_app/presentation/screens/signup/screen_signup.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:social_media_app/presentation/widgets/custom_signin_button.dart';
import 'package:social_media_app/presentation/widgets/custom_snakbar.dart';
import 'package:social_media_app/presentation/widgets/custom_textfield.dart';
import 'package:social_media_app/presentation/widgets/custom_validator.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenSignIn extends StatefulWidget {
  const ScreenSignIn({super.key});

  @override
  State<ScreenSignIn> createState() => _ScreenSignInState();
}

class _ScreenSignInState extends State<ScreenSignIn> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final loginbloc = context.read<LoginBloc>();
    return Scaffold(
      backgroundColor: kpurplelightColor,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            navigatePushandRemoveuntil(context, const SCreenmainpage());
          } else if (state is LoginErrorStateInvalidPassword) {
            customSnackbar(context, 'Invalid password', kredcolor);
          } else if (state is LoginErrorStateUsernotfound) {
            customSnackbar(context, 'user not found', kredcolor);
          } else if (state is LoginErrorStateAccountisBlocked) {
            customSnackbar(context, 'Account is blocked', kredcolor);
          } else if (state is LoginErrorStateInternalServerError) {
            customSnackbar(context, 'Internal server Error', kredcolor);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
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
                  child: Center(child: customHeadingtext('Hi There!', 30)),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 200),
                    width: size.width * .8,
                    height: 370,
                    decoration: BoxDecoration(
                        color: kwhiteColor, borderRadius: kradius20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          CustomTextfield(
                              controller: emailcontroller,
                              labelText: 'EmailAdress',
                              validator: validateEmail,
                              textInputType: TextInputType.emailAddress),
                          kheight,
                          CustomTextfield(
                              controller: passwordcontroller,
                              labelText: 'Password',
                              validator: validatePassword,
                              textInputType: TextInputType.visiblePassword),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenForgotPassword(),
                                  ),
                                );
                              },
                              child: const Text("Forgot password")),
                          kheight,
                          if (state is LoginLoadingstate)
                            const Center(
                              child: CircularProgressIndicator(
                                color: kpurpleBorderColor,
                              ),
                            ),
                          CustomSigninButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  loginbloc.add(LoginButtonClickEvent(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text));
                                } else {
                                  customSnackbar(
                                      context, 'fill All fields', kredcolor);
                                }
                              },
                              buttonText: 'signin'),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ScreenSignup(),
                                  ),
                                );
                              },
                              child: const Text("Don't Have an Account?"))
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
