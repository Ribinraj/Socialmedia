import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/data/models/signup_model.dart';
import 'package:social_media_app/presentation/bloc/signup/signup_bloc.dart';

import 'package:social_media_app/presentation/screens/otpscreen/screen_otp.dart';
import 'package:social_media_app/presentation/screens/signin/screen_signin.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';

import 'package:social_media_app/presentation/widgets/custom_signin_button.dart';
import 'package:social_media_app/presentation/widgets/custom_snakbar.dart';
import 'package:social_media_app/presentation/widgets/custom_textfield.dart';
import 'package:social_media_app/presentation/widgets/custom_validator.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenSignup extends StatefulWidget {
  const ScreenSignup({super.key});

  @override
  State<ScreenSignup> createState() => _ScreenSignupState();
}

class _ScreenSignupState extends State<ScreenSignup> {
  final usernameController = TextEditingController();
  final phonenumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final conformpasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserModel? userdetails;
    Size size = MediaQuery.of(context).size;
    final signupbloc = context.read<SignupBloc>();
    return Scaffold(
      backgroundColor: kpurplelightColor,
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccessState) {
            navigatePushandRemoveuntil(
              context,
              ScreenOtp(
                email: emailController.text,
                user: userdetails! ,
              ),
            );
            customSnackbar(context, 'Otp send Successfully', kgreencolor);
          } else if (state is SignupErrorStateAlreadyAccount) {
            customSnackbar(context, 'Already have an Account', kredcolor);
          }
          else if (state is SignupErrorStateUsernamealreadyUsed) {
            customSnackbar(context, 'Already have an Same Username', kredcolor);
          } else if (state is SignupErrorStateOtpalreadySent) {
            customSnackbar(context, 'Already otp sent', kredcolor);
          } else if (state is SignupErrorStateInternalServerError) {
            customSnackbar(context, 'Internal server error', kredcolor);
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
                  child: Center(child: customHeadingtext('Create Account', 30)),
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 190),
                    width: size.width * .8,
                    height: 600,
                    decoration: BoxDecoration(
                        color: kwhiteColor, borderRadius: kradius20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          kheight30,
                          CustomTextfield(
                              controller: usernameController,
                              labelText: 'Username',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'PLease enter your name';
                                }
                                return null;
                              },
                              textInputType: TextInputType.name),
                          CustomTextfield(
                              controller: phonenumberController,
                              labelText: 'Phone number',
                              validator:validateMobileNumber,
                              textInputType: TextInputType.number),
                          CustomTextfield(
                              controller: emailController,
                              labelText: 'EmailAdress',
                              validator: validateEmail,
                              textInputType: TextInputType.emailAddress),
                          CustomTextfield(
                              controller: passwordController,
                              labelText: 'Password',
                              validator: validatePassword,
                              textInputType: TextInputType.visiblePassword),
                          CustomTextfield(
                              controller: conformpasswordController,
                              labelText: 'Conform Password',
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value != passwordController.text) {
                                  return 'Enter correct password';
                                }
                                return null;
                              },
                              textInputType: TextInputType.visiblePassword),
                          CustomSigninButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  final user = UserModel(
                                      email: emailController.text,
                                      userName: usernameController.text,
                                      phone: phonenumberController.text,
                                      password: passwordController.text);
                                  userdetails = user;
                                  signupbloc
                                      .add(SignupButtenClickEvent(user: user));
                                } else {
                                  customSnackbar(
                                      context, 'fill all fields', kredcolor);
                                }
                              },
                              buttonText: 'signup'),
                          GestureDetector(
                            onTap: () {
                              navigatePush(context, const ScreenSignIn());
                            },
                            child: const Text('Have an Account?'),
                          ),
                          kheight
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
