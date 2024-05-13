import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/connection_count/connection_count_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/follow_unfollow/follow_unfollow_bloc.dart';
import 'package:social_media_app/presentation/screens/profile_screen/widgets/follow_and_message_card.dart';

import 'package:social_media_app/presentation/screens/user_post/sreen_userpost.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';

import 'package:social_media_app/presentation/widgets/profilepic_section.dart';


class ScreenProfile extends StatefulWidget {
  final String id;
  final String backgroundimage;
  final String profilepic;
  final String username;
  final String? bio;
  const ScreenProfile(
      {super.key,
      required this.id,
      required this.backgroundimage,
      required this.profilepic,
      required this.username,
      this.bio});

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  @override
  void initState() {
    context
        .read<FetchingUserPostBloc>()
        .add(FetchingUserpostInitialEvent(userId: widget.id));
    context
        .read<FollowUnfollowBloc>()
        .add(IsfollowingInitialEvent(userId: widget.id));
    context
        .read<ConnectionCountBloc>()
        .add(ConnectionCountInitialEvent(userId: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final followUnfollow = context.read<FollowUnfollowBloc>();
    Size size = MediaQuery.of(context).size;
    const double circleContainerSize = 130.0;

    return Scaffold(
      body: SizedBox(
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  const SizedBox(
                    height: 430,
                    width: double.infinity,
                  ),
                  Stack(children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.backgroundimage),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 25,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: kradius10, color: kwhiteColor),
                              height: 30,
                              width: 40,
                              child: const Icon(
                                  Icons.arrow_back_ios_new_rounded))),
                    )
                  ]),
                  FollowAndMessageCard(widget: widget, followUnfollow: followUnfollow),
                  ProfilePicSection(
                      size: size,
                      circleContainerSize: circleContainerSize,
                      profilepic: widget.profilepic)
                ],
              ),
              BlocBuilder<FetchingUserPostBloc, FetchingUserPostState>(
                builder: (context, state) {
                  if (state is FetchUserPostLoadingState) {
                    return Center(
                        child: LoadingAnimationWidget.fourRotatingDots(
                            color: kpurpleMediumColor, size: 40));
                  } else if (state is FetchUserPostSuccessState) {
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      padding: const EdgeInsets.all(5),
                      shrinkWrap: true,
                      itemCount: state.userposts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            navigatePush(
                                context,
                                SreenUserPost(
                                  userId: state.userposts[index].userId.id,
                                  initialindex: index,
                                ));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(state.userposts[index].image),
                              ),
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
            ],
          ),
        ),
      ),
    );
  }
}

