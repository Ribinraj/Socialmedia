import 'package:flutter/material.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/presentation/bloc/explore_post_bloc/explore_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/like_unlikepost/like_unlike_post_bloc.dart';
import 'package:social_media_app/presentation/screens/home_screen/screen_home.dart';



class FavouriteSectionExplorePost extends StatefulWidget {
  const FavouriteSectionExplorePost({
    super.key,
    required this.likebloc,
    required this.state,
    required this.index,
  });

  final LikeUnlikePostBloc likebloc;
  final FetchexplorepostSuccessState state;
  final int index;

  @override
  State<FavouriteSectionExplorePost> createState() =>
      _FavouriteSectionExplorePostState();
}

class _FavouriteSectionExplorePostState
    extends State<FavouriteSectionExplorePost> {


  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (widget.state.exploreposts[widget.index].likes
            .contains(loginuserid)) {
          widget.likebloc.add(UnlikePostEvent(
              postid: widget.state.exploreposts[widget.index].id));

          widget.state.exploreposts[widget.index].likes.remove(loginuserid);
        } else {
          widget.state.exploreposts[widget.index].likes.add(loginuserid);
          widget.likebloc.add(LikepostEvent(
              postid: widget.state.exploreposts[widget.index].id));
        }
      },
      icon: Icon(Icons.favorite,
          color: widget.state.exploreposts[widget.index].likes
                  .contains(loginuserid)
              ? kredcolor
              : kwhiteColor),
    );
  }
}
