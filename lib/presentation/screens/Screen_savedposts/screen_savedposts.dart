import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';

import 'package:social_media_app/presentation/bloc/fetchsavedpost/fetch_saved_post_bloc.dart';

import 'package:social_media_app/presentation/bloc/like_unlikepost/like_unlike_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';
import 'package:social_media_app/presentation/screens/Screen_savedposts/favorite_section.dart';

import 'package:social_media_app/presentation/screens/Screen_savedposts/popupmenubutton.dart';
import 'package:social_media_app/presentation/screens/home_screen/widgets/comment_section.dart';

import 'package:social_media_app/presentation/widgets/custom_round_image.dart';

import 'package:social_media_app/presentation/widgets/tex.dart';

class SreenSavedPost extends StatefulWidget {
  const SreenSavedPost({super.key});

  @override
  State<SreenSavedPost> createState() => _SreenSavedPostState();
}

class _SreenSavedPostState extends State<SreenSavedPost> {
  @override
  void initState() {
    context.read<FetchSavedPostBloc>().add(FetchSavedpostInitialEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final likebloc = context.read<LikeUnlikePostBloc>();
    return Scaffold(
      appBar: AppBar(
        title: customHeadingtext('SavedPosts', 25,
            textColor: kpurpleColor, fontWeight: FontWeight.w500),
        backgroundColor: kpurpledoublelightColor,
        centerTitle: true,
      ),
      body: BlocConsumer<FetchSavedPostBloc, FetchSavedPostState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchSavedpostLoadingState) {
            return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: kpurpleMediumColor, size: 40));
          } else if (state is FetchSavedpostSuccessState) {
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: state.savedposts.length,
              itemBuilder: (context, index) {
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
                            CustomRoundImage(
                                circleContainerSize: 45,
                                imageUrl: state.savedposts[index].postId.userId
                                    .profilePic),
                            kwidth,
                            Column(
                              children: [
                                customHeadingtext(
                                    state.savedposts[index].postId.userId
                                        .userName,
                                    18,
                                    textColor: kblackColor,
                                    fontWeight: FontWeight.bold),
                                customstyletext('11 hours ago', 15,
                                    textColor: kgreycolor)
                              ],
                            ),
                            const Spacer(),
                            UnsaveMenuButton(
                              postId: state.savedposts[index].postId.id,
                            )
                          ],
                        ),
                        kheight,
                        Container(
                          width: size.width,
                          height: 340,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    state.savedposts[index].postId.image),
                              ),
                              borderRadius: kradius10),
                        ),
                        kheight,
                        SizedBox(
                          height: 50,
                          child: customHeadingtext(
                            state.savedposts[index].postId.description,
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
                                  FavouriteSectionSavedpost(
                                      state2: state2,
                                      likebloc: likebloc,
                                      state: state,
                                      index: index),
                                  customHeadingtext(
                                      '${state.savedposts[index].postId.likes.length}',
                                      15,
                                      fontWeight: FontWeight.w500,
                                      textColor: kblackColor),
                                  state.savedposts[index].postId.likes.length >
                                          1
                                      ? customHeadingtext('Likes', 15,
                                          textColor: kblackColor)
                                      : customHeadingtext('Like', 15,
                                          textColor: kblackColor),
                                  kwidth,
                                  CommentWidget(
                                      state2: state2,
                                      postId:
                                          state.savedposts[index].postId.id),
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
