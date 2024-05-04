import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchsavedpost/fetch_saved_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/followerspost/fetch_followerspost_bloc.dart';
import 'package:social_media_app/presentation/bloc/saved_post/saved_post_bloc.dart';
import 'package:social_media_app/presentation/screens/home_screen/widgets/reportpost.dart';

class ReportAndSavedPost extends StatelessWidget {
  const ReportAndSavedPost({
    super.key,
    required this.savedbloc,
    required this.state,
    required this.index,
  });

  final SavedPostBloc savedbloc;
  final FetchFollowersPostSuccessState state;
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SavedPostBloc, SavedPostState>(
      listener: (context, state) {
        if (state is SavedPostSuccessState) {
          context.read<FetchSavedPostBloc>().add(FetchSavedpostInitialEvent());
        } else if (state is UnsavedpostSuccessState) {
          context.read<FetchSavedPostBloc>().add(FetchSavedpostInitialEvent());
        }
      },
      child: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'Save') {
            if (state.followersposts[index].isSaved == false) {
              savedbloc.add(
                  SavedpostClickEvent(postId: state.followersposts[index].id));
              state.followersposts[index].isSaved = true;
            } else {
              savedbloc.add(UnsavedPostClickEvent(
                  postId: state.followersposts[index].id));
              state.followersposts[index].isSaved = false;
            }
          } else if (value == 'Report') {
            showDialog(
              context: context,
              builder: (context) => ReportPostDialog(
                index: index,
                state: state,
              ),
            );
          }
        },
        itemBuilder: (BuildContext context) => [
          PopupMenuItem(
            value: 'Save',
            child: state.followersposts[index].isSaved == true
                ? const Text('Saved')
                : const Text('save'),
          ),
          const PopupMenuItem(
            value: 'Report',
            child: Text('Report'),
          ),
        ],
      ),
    );
  }
}
