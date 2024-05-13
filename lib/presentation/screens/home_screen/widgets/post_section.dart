import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/followerspost/fetch_followerspost_bloc.dart';
import 'package:social_media_app/presentation/bloc/like_unlikepost/like_unlike_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';
import 'package:social_media_app/presentation/bloc/saved_post/saved_post_bloc.dart';
import 'package:social_media_app/presentation/screens/home_screen/widgets/comment_section.dart';
import 'package:social_media_app/presentation/screens/home_screen/widgets/favourit_section.dart';
import 'package:social_media_app/presentation/screens/home_screen/widgets/postusernamesession.dart';
import 'package:social_media_app/presentation/screens/home_screen/widgets/report_and_savedpost.dart';
import 'package:social_media_app/presentation/screens/profile_screen/profile_screen.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:social_media_app/presentation/widgets/custom_round_image.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class PostSection extends StatelessWidget {
  const PostSection({
    super.key,
    required this.savedbloc,
    required this.size,
    required this.likebloc,
    required this.state, required this.index,
  });
  final FetchFollowersPostSuccessState state;
  final SavedPostBloc savedbloc;
  final Size size;
  final LikeUnlikePostBloc likebloc;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.only(
          top: 10,
          left: 5,
          right: 5,
        ),
        height: 515,
        width: double.infinity,
        decoration: BoxDecoration(
            color: kpurpledoublelightColor, borderRadius: kradius10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    navigatePush(
                      context,
                      ScreenProfile(
                          id: state.followersposts[index].userId.id,
                          backgroundimage: state
                              .followersposts[index].userId.backGroundImage,
                          profilepic:
                              state.followersposts[index].userId.profilePic,
                          username:
                              state.followersposts[index].userId.userName),
                    );
                  },
                  child: CustomRoundImage(
                      circleContainerSize: 45,
                      imageUrl: state.followersposts[index].userId.profilePic),
                ),
                kwidth,
                PostUsernameSection(
                  state: state,
                  index: index,
                ),
                kwidth30,
                const Spacer(),
                ReportAndSavedPost(
                  savedbloc: savedbloc,
                  state: state,
                  index: index,
                )
              ],
            ),
            kheight,
            Container(
              width: size.width,
              height: 335,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(state.followersposts[index].image),
                  ),
                  borderRadius: kradius10),
            ),
            kheight,
            SizedBox(
              height: 50,
              child: customHeadingtext(
                state.followersposts[index].description,
                16,
                textColor: kblackColor,
              ),
            ),
            MultiBlocBuilder(
              blocs: [
                context.watch<LikeUnlikePostBloc>(),
                context.watch<LoginUserBloc>(),
              ],
              builder: (context, states) {
                //var state1 = states[0];
                var state2 = states[1];
                if (state2 is LoginUserSuccessState) {
                  return Row(
                    children: [
                      FavouriteSection(
                          state: state,
                          index: index,
                          state2: state2,
                          likebloc: likebloc),
                      customHeadingtext(
                          '${state.followersposts[index].likes.length}', 15,
                          fontWeight: FontWeight.w500, textColor: kblackColor),
                      state.followersposts[index].likes.length > 1
                          ? customHeadingtext('Likes', 15,
                              textColor: kblackColor)
                          : customHeadingtext('Like', 15,
                              textColor: kblackColor),
                      kwidth,
                      CommentWidget(
                          state2: state2,
                          postId: state.followersposts[index].id),
                    ],
                  );
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}