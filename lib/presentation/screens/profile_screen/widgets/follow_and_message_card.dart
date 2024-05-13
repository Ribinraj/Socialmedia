import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/connection_count/connection_count_bloc.dart';
import 'package:social_media_app/presentation/bloc/follow_unfollow/follow_unfollow_bloc.dart';
import 'package:social_media_app/presentation/screens/profile_screen/profile_screen.dart';
import 'package:social_media_app/presentation/screens/profile_screen/widgets/follow_and_message_section.dart';
import 'package:social_media_app/presentation/widgets/followers_following_loading.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class FollowAndMessageCard extends StatelessWidget {
  const FollowAndMessageCard({
    super.key,
    required this.widget,
    required this.followUnfollow,
  });

  final ScreenProfile widget;
  final FollowUnfollowBloc followUnfollow;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
                  left: 35, right: 35, top: 15, bottom: 15),
              child: BlocBuilder<ConnectionCountBloc,
                  ConnectionCountState>(
                builder: (context, state) {
                  if (state is ConnectionCountLoadingState) {
                    return const FollowersFollowingLoadingState();
                  } else if (state
                      is ConnectionCountSuccessState) {
                    return Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              customHeadingtext(
                                  '${state.followersCount} ', 17,
                                  textColor: kblackColor,
                                  fontWeight: FontWeight.bold),
                              customHeadingtext('Followers', 15,
                                  fontWeight: FontWeight.w500,
                                  textColor: kblackColor)
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              customHeadingtext(
                                  '${state.followingCount} ', 17,
                                  textColor: kblackColor,
                                  fontWeight: FontWeight.bold),
                              customHeadingtext('Following', 15,
                                  fontWeight: FontWeight.w500,
                                  textColor: kblackColor)
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            customHeadingtext(widget.username, 22,
                textColor: kblackColor,
                fontWeight: FontWeight.w500),
            customHeadingtext(widget.bio ?? '', 17,
                textColor: kblackColor),
            FollowAndMessageSection(
                widget: widget, followUnfollow: followUnfollow),
            kheight,
            customHeadingtext('All Posts', 20,
                textColor: kblackColor,
                fontWeight: FontWeight.w500)
          ],
        ),
      ),
    );
  }
}
