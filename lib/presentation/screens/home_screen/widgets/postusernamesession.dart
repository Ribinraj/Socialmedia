import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/presentation/bloc/followerspost/fetch_followerspost_bloc.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';
import 'package:timeago/timeago.dart' as timeago;
class PostUsernameSection extends StatelessWidget {
  const PostUsernameSection({
    super.key, required this.state, required this.index,
  });
  final FetchFollowersPostSuccessState state;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customHeadingtext(state.followersposts[index].userId.userName, 18,
            textColor: kblackColor, fontWeight: FontWeight.bold),
        state.followersposts[index].createdAt !=
                state.followersposts[index].updatedAt
            ? customstyletext(
                '${timeago.format(state.followersposts[index].updatedAt)}(edited)',
                13,
                textColor: kgreycolor)
            : customstyletext(
                timeago.format(state.followersposts[index].createdAt), 13,
                textColor: kgreycolor),
      ],
    );
  }
}