import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';


import 'package:social_media_app/presentation/bloc/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/follow_unfollow/follow_unfollow_bloc.dart';
import 'package:social_media_app/presentation/bloc/suggession_bloc/suggession_users_bloc.dart';

import 'package:social_media_app/presentation/widgets/custom_profile_button.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenProfile extends StatefulWidget {
  final String id;
  final String backgroundimage;
  final String profilepic;
  final String username;
  final String? bio;
  const ScreenProfile({super.key,  required this.id, required this.backgroundimage, required this.profilepic, required this.username, this.bio});

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
                    top: 200.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 230,
                      decoration: const BoxDecoration(
                        color: kpurplelightColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 35, right: 35, top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      customHeadingtext('100K ', 17,
                                          textColor: kblackColor,
                                          fontWeight: FontWeight.bold),
                                      customHeadingtext('Followers', 15,
                                          fontWeight: FontWeight.w400,
                                          textColor: kblackColor)
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      customHeadingtext('100K', 17,
                                          textColor: kblackColor,
                                          fontWeight: FontWeight.bold),
                                      customHeadingtext('Following', 15,
                                          fontWeight: FontWeight.w400,
                                          textColor: kblackColor)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          customHeadingtext(widget.username, 22,
                              textColor: kblackColor,
                              fontWeight: FontWeight.w500),
                          customHeadingtext(widget.bio ?? '', 17,
                              textColor: kblackColor),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocConsumer<FollowUnfollowBloc,
                                  FollowUnfollowState>(
                                listener: (context, state) {
                                  if (state is FollowuserSuccessState) {
                                    context.read<FollowUnfollowBloc>().add(
                                        IsfollowingInitialEvent(
                                            userId: widget.id));
                                    context
                                        .read<SuggessionUsersBloc>()
                                        .add(SuggessionUsersInitialEvent());
                                  } else if (state
                                      is UnfollowuserSuccessState) {
                                    context.read<FollowUnfollowBloc>().add(
                                        IsfollowingInitialEvent(
                                            userId: widget.id));
                                    context
                                        .read<SuggessionUsersBloc>()
                                        .add(SuggessionUsersInitialEvent());
                                  }
                                },
                                builder: (context, state) {
                                  if (state is IsfollowingSuccessState) {
                                    bool isfollowing = state.isfollowing;
                                    return CustomProfilebutton(
                                        onPressed: () {
                                          if (isfollowing == false) {
                                            isfollowing = true;
                                            followUnfollow.add(
                                                FollowButtonClickEvent(
                                                    followeeId:
                                                        widget.id));
                                          } else {
                                            isfollowing = false;
                                            followUnfollow.add(
                                                UnFollowButtonClickEvent(
                                                    unfolloweeId:
                                                        widget.id));
                                          }
                                        },
                                        buttonText: isfollowing == false
                                            ? 'Follow'
                                            : 'Unfollow');
                                  } else {
                                    return CustomProfilebutton(
                                        onPressed: () {}, buttonText: '');
                                  }
                                },
                              ),
                              kwidth20,
                              CustomProfilebutton(
                                  onPressed: () {}, buttonText: 'Message')
                            ],
                          ),
                          kheight,
                          customHeadingtext('All Posts', 20,
                              textColor: kblackColor,
                              fontWeight: FontWeight.w500)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: (size.width - circleContainerSize) / 2,
                    child: Container(
                      height: circleContainerSize,
                      width: circleContainerSize,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: UnconstrainedBox(
                        child: ClipOval(
                          child: Container(
                            height: circleContainerSize - 10,
                            width: circleContainerSize - 10,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  widget.profilepic,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(state.userposts[index].image),
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
