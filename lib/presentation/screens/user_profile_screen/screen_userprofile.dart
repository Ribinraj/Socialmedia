import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/fetchpost/fetch_post_bloc.dart';

import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';

import 'package:social_media_app/presentation/screens/profile_screen/profile_screen.dart';

import 'package:social_media_app/presentation/screens/user_profile_screen/widgets/allpost_widget.dart';

import 'package:social_media_app/presentation/screens/user_profile_screen/widgets/editprofile_settings_row.dart';


import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenUserProfile extends StatefulWidget {
  const ScreenUserProfile({super.key});

  @override
  State<ScreenUserProfile> createState() => _ScreenUserProfileState();
}

class _ScreenUserProfileState extends State<ScreenUserProfile>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<FetchPostBloc>().add(FetchPostInitialEvent());
    context.read<LoginUserBloc>().add(LoginUserInitialFetchingEvent());
    // context.read<FetchingUserPostBloc>().add(FetchingUserpostInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double circleContainerSize = 130.0;

    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocConsumer<LoginUserBloc, LoginUserState>(
                    listener: (context, state1) {},
                    builder: (context, state1) {
                      if (state1 is LoginUserLoadingState) {
                        return Center(
                            child: LoadingAnimationWidget.fourRotatingDots(
                                color: kpurpleMediumColor, size: 40));
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
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      state1.loginuserdata.backGroundImage),
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
                                                        ScreenProfile()),
                                              );
                                            },
                                            child: Column(
                                              children: [
                                                customHeadingtext('100K ', 17,
                                                    textColor: kblackColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                customHeadingtext(
                                                    'Followers', 15,
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                                customHeadingtext(
                                                    'Following', 15,
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
                                    customHeadingtext(
                                        state1.loginuserdata.bio, 17,
                                        textColor: kblackColor),
                                    EditAndSettingsRow(
                                      state1: state1,
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
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'All Posts'),
                      Tab(text: 'Saved Posts'),
                    ],
                  ),
                  BlocBuilder<FetchPostBloc, FetchPostState>(
                    builder: (context, state) {
                      if (state is FetchPostLoadingState) {
                        return Center(
                            child: LoadingAnimationWidget.fourRotatingDots(
                                color: kpurpleMediumColor, size: 40));
                      } else if (state is FetchPostSuccessState) {
                        return AutoScaleTabBarView(
                          controller: _tabController,
                          children: [
                             AllpostWidget(state: state,),
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount:
                                    3, // Adjust for desired number of columns
                                crossAxisSpacing: 5.0,
                                mainAxisSpacing: 5.0,
                              ),
                              itemBuilder: (context, index) {
                                return Container(
                                  color: kpurpleColor,
                                );
                              },
                              itemCount: 10,
                            ),
                          ],
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
        ]),
      ),
    );
  }
}


