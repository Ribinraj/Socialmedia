import 'package:flutter/material.dart';

import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';
import 'package:social_media_app/presentation/screens/home_screen/widgets/comment_sheet.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget({
    super.key,
    required this.state2,
   required this.postId,
  });

  final LoginUserSuccessState state2;
  
  final String postId;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return DraggableScrollableSheet(
                initialChildSize: 1,
                minChildSize: 0.6,
                maxChildSize: 1,
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return CommentPage(
                    scrollController: scrollController,
                    postId:postId,
                    state2: state2,
                  );
                },
              );
            },
          );
        },
        icon: const Icon(Icons.comment));
  }
}
