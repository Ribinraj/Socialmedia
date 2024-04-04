import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';

import 'package:social_media_app/presentation/bloc/fetchuserpost/fetching_user_post_bloc.dart';

import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';

import 'package:social_media_app/presentation/screens/editprofile/screen_editprofile.dart';
import 'package:social_media_app/presentation/screens/profile_screen/profile_screen.dart';

import 'package:social_media_app/presentation/screens/settings/screen_settings.dart';
import 'package:social_media_app/presentation/screens/user_post/sreen_userpost.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:social_media_app/presentation/widgets/custom_profile_button.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenUserProfile extends StatefulWidget {
  const ScreenUserProfile({super.key});

  @override
  State<ScreenUserProfile> createState() => _ScreenUserProfileState();
}

class _ScreenUserProfileState extends State<ScreenUserProfile> {
  @override
  void initState() {
    context.read<LoginUserBloc>().add(LoginUserInitialFetchingEvent());
    context.read<FetchingUserPostBloc>().add(FetchingUserpostInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double circleContainerSize = 130.0;

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocConsumer<LoginUserBloc, LoginUserState>(
                  listener: (context, state1) {},
                  builder: (context, state1) {
                    if (state1 is LoginUserLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kpurpleBorderColor,
                        ),
                      );
                    } else if (state1 is LoginUserSuccessState) {
                      return Stack(
                        children: [
                          const SizedBox(
                            height: 430,
                            width: double.infinity,
                          ),
                          Container(
                            width: double.infinity,
                            height: 250,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://images.pexels.com/photos/707046/pexels-photo-707046.jpeg?cs=srgb&dl=pexels-trace-constant-707046.jpg&fm=jpg"),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 200.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              height: 230,
                              decoration: const BoxDecoration(
                                color: kpurplelightColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 35,
                                        right: 35,
                                        top: 15,
                                        bottom: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ScreenProfile()));
                                          },
                                          child: Column(
                                            children: [
                                              customHeadingtext('100K ', 17,
                                                  textColor: kblackColor,
                                                  fontWeight: FontWeight.bold),
                                              customHeadingtext('Followers', 15,
                                                  fontWeight: FontWeight.w400,
                                                  textColor: kblackColor)
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Column(
                                            children: [
                                              customHeadingtext('100K', 17,
                                                  textColor: kblackColor,
                                                  fontWeight: FontWeight.bold),
                                              customHeadingtext('Following', 15,
                                                  fontWeight: FontWeight.w400,
                                                  textColor: kblackColor)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  customHeadingtext(
                                      state1.loginuserdata.userName, 22,
                                      textColor: kblackColor,
                                      fontWeight: FontWeight.w500),
                                  customHeadingtext('Amarambalam south ', 17,
                                      textColor: kblackColor),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomProfilebutton(
                                              onPressed: () {
                                                navigatePush(context,
                                                   SreenProfileEdit(loginuser: state1.loginuserdata,));
                                              },
                                              buttonText: 'Edit Profile'),
                                          kwidth20,
                                          CustomProfilebutton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ScreenSettings(),
                                                  ),
                                                );
                                              },
                                              buttonText: 'Settings')
                                        ],
                                      ),
                                    ],
                                  ),
                                  kheight,
                                  customHeadingtext('All Posts', 20,
                                      textColor: kblackColor,
                                      fontWeight: FontWeight.w500)
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 140,
                            left: (size.width - circleContainerSize) / 2,
                            child: Container(
                              height: circleContainerSize,
                              width: circleContainerSize,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: UnconstrainedBox(
                                child: ClipOval(
                                  child: Container(
                                    height: circleContainerSize - 10,
                                    width: circleContainerSize - 10,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          state1.loginuserdata.profilePic,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                BlocBuilder<FetchingUserPostBloc, FetchingUserPostState>(
                  builder: (context, state) {
                    if (state is FetchUserPostLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: kpurpleBorderColor,
                        ),
                      );
                    } else if (state is FetchUserPostSuccessState) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        padding: const EdgeInsets.all(5),
                        shrinkWrap: true,
                        itemCount: state.userposts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              navigatePush(context, const SreenUserPost());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    state.userposts[index].image,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
