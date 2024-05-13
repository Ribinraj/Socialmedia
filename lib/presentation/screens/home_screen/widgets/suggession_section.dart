

import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/suggession_bloc/suggession_users_bloc.dart';
import 'package:social_media_app/presentation/screens/profile_screen/profile_screen.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:social_media_app/presentation/widgets/custom_round_image.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class SuggessionPart extends StatelessWidget {
  const SuggessionPart({
    super.key,
    required this.circleContainerSize, required this.state3,
  });
  final SuggessionUsersSuccessState state3;
  final double circleContainerSize;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => const SizedBox(width: 10),
      itemCount: state3.suggessions.data.length,
      itemBuilder: (context, index) {
        final details = state3.suggessions.data[index];
        return Column(
          children: [
            kheight,
            InkWell(
              onTap: () {
                navigatePush(
                    context,
                    ScreenProfile(
                      id: details.id,
                      backgroundimage: details.backGroundImage,
                      profilepic: details.profilePic,
                      username: details.userName,
                      bio: details.bio,
                    ));
              },
              child: CustomRoundImage(
                  circleContainerSize: circleContainerSize,
                  imageUrl: state3.suggessions.data[index].profilePic),
            ),
            customHeadingtext(state3.suggessions.data[index].userName, 13,
                fontWeight: FontWeight.w500, textColor: kblackColor)
          ],
        );
      },
    );
  }
}
