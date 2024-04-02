import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/data/models/signup_model.dart';
import 'package:social_media_app/presentation/bloc/otp/otp_bloc.dart';
import 'package:social_media_app/presentation/bloc/signup/signup_bloc.dart';

import 'package:social_media_app/presentation/screens/signin/screen_signin.dart';
import 'package:social_media_app/presentation/widgets/custom_signin_button.dart';
import 'package:social_media_app/presentation/widgets/custom_snakbar.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenOtp extends StatefulWidget {
  const ScreenOtp({super.key, required this.email, required this.user});
  final String email;
  final UserModel user;

  @override
  State<ScreenOtp> createState() => _ScreenOtpState();
}

class _ScreenOtpState extends State<ScreenOtp> {
  String otp = '';
  int resendTime = 60;
  late Timer countdownTimer;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendTime = resendTime - 1;
      });
      if (resendTime < 1) {
        countdownTimer.cancel();
      }
    });
  }

  stopTimer() {
    if (countdownTimer.isActive) {
      countdownTimer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final otpbloc = context.read<OtpBloc>();
    final signupbloc = context.read<SignupBloc>();

    return Scaffold(
      body: BlocConsumer<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is OtpSuccessState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const ScreenSignIn()),
                (route) => false);
          } else if (state is OtpErrorStateInvalidOtp) {
            customSnackbar(context, 'Invalid otp', kredcolor);
          } else if (state is OtpErrorStateInternalServerError) {
            customSnackbar(context, 'Internal server error', kredcolor);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    customHeadingtext(
                        'Enter 4 digit Verification code \nsent to your Email',
                        24,
                        textColor: kblackColor),
                    kheight30,
                    OtpTextField(
                      numberOfFields: 4,
                      borderColor: kpurplelightColor,
                      enabledBorderColor: kpurpleMediumColor,
                      showFieldAsBox: true,
                      onCodeChanged: (String code) {},
                      onSubmit: (String verificationCode) {
                        otp = verificationCode;
                      },
                    ),
                    kheight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customHeadingtext('Havent received OTP yet?', 15,
                            textColor: kblackColor),
                            kwidth,
                        resendTime == 0
                            ? InkWell(
                                onTap: () {
                                  signupbloc
                                      .add(SignupButtenClickEvent(user:widget.user));
                                },
                                child: customHeadingtext('Resend', 15,
                                    textColor: kredcolor),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    kheight,
                    resendTime != 0
                        ? customHeadingtext(
                            'You can resend OTP after $resendTime seconds(s)',
                            15,
                            textColor: kgreencolor)
                        : const SizedBox(),
                    CustomSigninButton(
                        onPressed: () {
                          if (otp.isNotEmpty) {
                            otpbloc.add(OtpverifyClickevent(
                                email: widget.email, otp: otp));
                          } else {
                            customSnackbar(
                                context, 'please enter otp', kredcolor);
                          }
                        },
                        buttonText: 'Verify')
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
