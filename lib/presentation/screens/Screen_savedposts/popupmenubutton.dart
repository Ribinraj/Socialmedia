import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchsavedpost/fetch_saved_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/followerspost/fetch_followerspost_bloc.dart';
import 'package:social_media_app/presentation/bloc/saved_post/saved_post_bloc.dart';


class UnsaveMenuButton extends StatelessWidget {
  const UnsaveMenuButton({Key? key, required this.postId}) : super(key: key);
  final String postId;
  @override
  Widget build(BuildContext context) {
    final savedbloc = context.read<SavedPostBloc>();
    return BlocListener<SavedPostBloc, SavedPostState>(
      listener: (context, state) {
       if (state is UnsavedpostSuccessState) {
          context
                .read<FetchSavedPostBloc>()
                .add(FetchSavedpostInitialEvent());
                 context
        .read<FetchFollowerspostBloc>()
        .add(InitialFetchingEventFollowersPost(n:1));
       }
      },
      child: PopupMenuButton<String>(
        onSelected: (String value) {
          if (value == 'unsave') {
            savedbloc.add(UnsavedPostClickEvent(postId: postId));

           
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'unsave',
            child: Text('Unsave'),
          ),
        ],
        icon: const Icon(Icons.more_vert),
      ),
    );
  }
}
