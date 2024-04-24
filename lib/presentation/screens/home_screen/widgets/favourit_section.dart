import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/data/models/followers_post.dart';
import 'package:social_media_app/presentation/bloc/followerspost/fetch_followerspost_bloc.dart';
import 'package:social_media_app/presentation/bloc/like_unlikepost/like_unlike_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';

class FavouriteSection extends StatelessWidget {
  const FavouriteSection({
    super.key,
    required this.state2,
    required this.likebloc, required this.state, required this.index,
  });

  final LoginUserSuccessState state2;
  final LikeUnlikePostBloc likebloc;
  final FetchFollowersSuccessState state;
  final int index;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (state.followersposts[index].isLiked == false) {
            state.followersposts[index].isLiked = true;
            state.followersposts[index].likes
                .add(UserId.fromJson(state2.loginuserdata.toJson()));
            likebloc.add(LikepostEvent(postid: state.followersposts[index].id));
          } else {
            state.followersposts[index].isLiked = false;
            state.followersposts[index].likes.removeWhere(
                (element) => element.id == state2.loginuserdata.id);
            likebloc
                .add(UnlikePostEvent(postid: state.followersposts[index].id));
          }
        },
        icon: Icon(Icons.favorite,
            color: state.followersposts[index].isLiked == true
                ? kredcolor
                : kwhiteColor),);
  }
}