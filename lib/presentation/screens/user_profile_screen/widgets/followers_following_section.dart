


import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/presentation/bloc/fetch_followers/fetch_followers_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetch_following.dart/fetch_followings_bloc.dart';
import 'package:social_media_app/presentation/screens/followers_screen/followers_screen.dart';
import 'package:social_media_app/presentation/screens/following_screen/folloing_screen.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class FollowingFollowersSection extends StatelessWidget {
  const FollowingFollowersSection({
    super.key,
    required this.state2,
    required this.state3,
  });

  final FetchFollowersSuccessState state2;
  final FetchFollowingSuccessState state3;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment
              .spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const FollowersScreen()),
            );
          },
          child: Column(
            children: [
              customHeadingtext(
                  '${state2.followers.followers.length}',
                  17,
                  textColor:
                      kblackColor,
                  fontWeight:
                      FontWeight.bold),
              customHeadingtext(
                  'Followers', 15,
                  fontWeight:
                      FontWeight.w500,
                  textColor:
                      kblackColor)
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            navigatePush(context,
                const FollowingScreen());
          },
          child: Column(
            children: [
              customHeadingtext(
                  '${state3.followings.following.length}',
                  17,
                  textColor:
                      kblackColor,
                  fontWeight:
                      FontWeight.bold),
              customHeadingtext(
                  'Following', 15,
                  fontWeight:
                      FontWeight.w500,
                  textColor:
                      kblackColor)
            ],
          ),
        ),
      ],
    );
  }
}

