import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/presentation/bloc/fetchsavedpost/fetch_saved_post_bloc.dart';

import 'package:social_media_app/presentation/bloc/like_unlikepost/like_unlike_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';

class FavouriteSectionSavedpost extends StatelessWidget {
  const FavouriteSectionSavedpost({
    super.key,
    required this.state2,
    required this.likebloc,
    required this.state,
    required this.index,
  });

  final LoginUserSuccessState state2;
  final LikeUnlikePostBloc likebloc;
  final FetchSavedpostSuccessState state;
  final int index;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (state.savedposts[index].postId.likes
            .contains(state2.loginuserdata.id)) {
          likebloc
              .add(UnlikePostEvent(postid: state.savedposts[index].postId.id));

          state.savedposts[index].postId.likes.remove(state2.loginuserdata.id);
        } else {
          state.savedposts[index].postId.likes.add(state2.loginuserdata.id);
          likebloc
              .add(LikepostEvent(postid: state.savedposts[index].postId.id));
        }
      },
      icon: Icon(Icons.favorite,
          color: state.savedposts[index].postId.likes
                  .contains(state2.loginuserdata.id)
              ? kredcolor
              : kwhiteColor),
    );
  }
}
