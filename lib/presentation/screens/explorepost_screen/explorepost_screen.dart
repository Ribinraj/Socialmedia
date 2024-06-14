import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/explore_post_bloc/explore_post_bloc.dart';
import 'package:social_media_app/presentation/screens/profile_screen/profile_screen.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media_app/presentation/bloc/like_unlikepost/like_unlike_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';

import 'package:social_media_app/presentation/screens/explorepost_screen/widgets/favorite_section.dart';
import 'package:social_media_app/presentation/screens/home_screen/widgets/comment_section.dart';

import 'package:social_media_app/presentation/widgets/custom_round_image.dart';

import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenExplorePost extends StatefulWidget {
  final int initialIndex;
  const ScreenExplorePost({super.key, required this.initialIndex});

  @override
  State<ScreenExplorePost> createState() => _SreenSavedPostState();
}

class _SreenSavedPostState extends State<ScreenExplorePost> {
  @override
  void initState() {
    context.read<ExplorePostBloc>().add(FetchexplorepostInitialEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final likebloc = context.read<LikeUnlikePostBloc>();
    return Scaffold(
      appBar: AppBar(
        title: customHeadingtext('Explore Posts', 25,
            textColor: kpurpleColor, fontWeight: FontWeight.w500),
        backgroundColor: kpurpledoublelightColor,
        centerTitle: true,
      ),
      body: BlocConsumer<ExplorePostBloc, ExplorePostState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchExplorepostLoadingState) {
            return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: kpurpleMediumColor, size: 40));
          } else if (state is FetchexplorepostSuccessState) {
            return ListView.separated(
              controller: ScrollController(
                  initialScrollOffset: widget.initialIndex * 450),
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: state.exploreposts.length,
              itemBuilder: (context, index) {
                final explorepost = state.exploreposts[index];
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 5,
                      right: 5,
                    ),
                    height: 520,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: kpurpledoublelightColor,
                        borderRadius: kradius10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                navigatePush(context,ScreenProfile(id: explorepost.userId.id, backgroundimage: explorepost.userId.backGroundImage, profilepic:explorepost.userId.profilePic, username:explorepost.userId.userName));
                              },
                              child: CustomRoundImage(
                                  circleContainerSize: 45,
                                  imageUrl: explorepost.userId.profilePic),
                            ),
                            kwidth,
                            Column(
                              children: [
                                customHeadingtext(
                                    explorepost.userId.userName, 18,
                                    textColor: kblackColor,
                                    fontWeight: FontWeight.bold),
                                state.exploreposts[index].createdAt !=
                                        state.exploreposts[index].updatedAt
                                    ? customstyletext(
                                        '${timeago.format(state.exploreposts[index].updatedAt)}(edited)',
                                        13,
                                        textColor: kgreycolor)
                                    : customstyletext(
                                        timeago.format(state
                                            .exploreposts[index].createdAt),
                                        13,
                                        textColor: kgreycolor),
                              ],
                            ),
                          ],
                        ),
                        kheight,
                        Container(
                          width: size.width,
                          height: 340,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(explorepost.image),
                              ),
                              borderRadius: kradius10),
                        ),
                        kheight,
                        SizedBox(
                          height: 50,
                          child: customHeadingtext(
                            explorepost.description,
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
                                  FavouriteSectionExplorePost(
                                      likebloc: likebloc,
                                      state: state,
                                      index: index),
                                  customHeadingtext(
                                      '${explorepost.likes.length}', 15,
                                      fontWeight: FontWeight.w500,
                                      textColor: kblackColor),
                                  explorepost.likes.length > 1
                                      ? customHeadingtext('Likes', 15,
                                          textColor: kblackColor)
                                      : customHeadingtext('Like', 15,
                                          textColor: kblackColor),
                                  kwidth,
                                  CommentWidget(
                                      state2: state2, postId: explorepost.id),
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
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
