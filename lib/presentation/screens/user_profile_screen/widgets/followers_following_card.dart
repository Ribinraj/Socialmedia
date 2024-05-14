

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/fetch_followers/fetch_followers_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetch_following.dart/fetch_followings_bloc.dart';
import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';
import 'package:social_media_app/presentation/screens/user_profile_screen/widgets/editprofile_settings_row.dart';
import 'package:social_media_app/presentation/screens/user_profile_screen/widgets/followers_following_section.dart';
import 'package:social_media_app/presentation/widgets/followers_following_loading.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class FollowersFollowingCard extends StatelessWidget {
  const FollowersFollowingCard({
    super.key, required this.state1,
  });
  final LoginUserSuccessState state1;
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
              child: MultiBlocBuilder(
                blocs: [
                  context.watch<FetchFollowersBloc>(),
                  context.watch<FetchFollowingsBloc>()
                ],
                builder: (context, state1) {
                  var state2 = state1[0];
                  var state3 = state1[1];
                  if (state2 is FetchFollowersLoadingState &&
                      state3 is FetchFollowingLoadingState) {
                    return const FollowersFollowingLoadingState();
                  } else if (state2 is FetchFollowersSuccessState &&
                      state3 is FetchFollowingSuccessState) {
                    return FollowingFollowersSection(
                        state2: state2, state3: state3);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            customHeadingtext(state1.loginuserdata.userName, 22,
                textColor: kblackColor, fontWeight: FontWeight.w500),
            customHeadingtext(state1.loginuserdata.bio??'', 17,
                textColor: kblackColor),
            EditAndSettingsRow(
              state1: state1,
            ),
            kheight,
            customHeadingtext('All Posts', 20,
                textColor: kblackColor, fontWeight: FontWeight.w500)
          ],
        ),
      ),
    );
  }
}
