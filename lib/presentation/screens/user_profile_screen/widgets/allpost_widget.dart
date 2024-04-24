import 'package:flutter/material.dart';
import 'package:social_media_app/presentation/bloc/fetchpost/fetch_post_bloc.dart';
import 'package:social_media_app/presentation/screens/user_post/sreen_userpost.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';

class AllpostWidget extends StatelessWidget {
  const AllpostWidget({
    super.key, required this.state,
  });
  final FetchPostSuccessState state;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      padding: const EdgeInsets.all(5),
      shrinkWrap: true,
      itemCount: state.posts.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            navigatePush(
                context,
                SreenUserPost(
                  userId: state.posts[index].userId.id,
                ));
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  state.posts[index].image,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}