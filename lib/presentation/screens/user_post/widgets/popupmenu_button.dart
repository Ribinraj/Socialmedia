

import 'package:flutter/material.dart';
import 'package:social_media_app/presentation/bloc/deletepost/delete_post_bloc.dart';

import 'package:social_media_app/presentation/bloc/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:social_media_app/presentation/screens/editpost/sreen_editpost.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';

class PopupmenuButton extends StatelessWidget {
  const PopupmenuButton(
      {super.key, required this.deletoepostBloc, required this.state, required this.index});

  final DeletePostBloc deletoepostBloc;
  final FetchUserPostSuccessState state;
  final int index;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          value: 'edit',
          child: Text('Edit'),
        ),
        const PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
      onSelected: (value) {
        // Handle the selected option here
        if (value == 'edit') {
          navigatePush(
              context,
              ScreenEditPost(
                userpost: state.userposts[index],
              ));
        } else if (value == 'delete') {
          deletoepostBloc
              .add(DeletepostClickEvent(postid: state.userposts[index].id));
        }
      },
      icon: const Icon(Icons.more_vert),
    );
  }
}