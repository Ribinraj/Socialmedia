import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';

import 'package:social_media_app/presentation/bloc/fetchuserpost/fetching_user_post_bloc.dart';

import 'package:social_media_app/presentation/bloc/like_unlikepost/like_unlike_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';

class FavouriteSectionUserpost extends StatelessWidget {
  const FavouriteSectionUserpost({
    super.key,
    required this.state2,
    required this.likebloc,
    required this.state,
    required this.index,
  });

  final LoginUserSuccessState state2;
  final LikeUnlikePostBloc likebloc;
  final FetchUserPostSuccessState state;
  final int index;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (state.userposts[index].likes.contains(state2.loginuserdata.id)) {
          likebloc.add(UnlikePostEvent(postid: state.userposts[index].id));

          state.userposts[index].likes.remove(state2.loginuserdata.id);
        } else {
          state.userposts[index].likes.add(state2.loginuserdata.id);
          likebloc.add(LikepostEvent(postid: state.userposts[index].id));
        }
      },
      icon: Icon(Icons.favorite,
          color: state.userposts[index].likes.contains(state2.loginuserdata.id)
              ? kredcolor
              : kwhiteColor),
    );
  }
}
