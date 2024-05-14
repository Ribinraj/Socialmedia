import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/core/colors.dart';

import 'package:social_media_app/presentation/bloc/fetch_followers/fetch_followers_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetch_following.dart/fetch_followings_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchpost/fetch_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchsavedpost/fetch_saved_post_bloc.dart';

import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';
import 'package:social_media_app/presentation/screens/Screen_savedposts/screen_savedposts.dart';
import 'package:social_media_app/presentation/screens/search_screen/widgets/debouncer.dart';

import 'package:social_media_app/presentation/screens/user_profile_screen/widgets/allpost_widget.dart';

import 'package:social_media_app/presentation/screens/user_profile_screen/widgets/followers_following_card.dart';

import 'package:social_media_app/presentation/widgets/custom_navigator.dart';

import 'package:social_media_app/presentation/widgets/profilepic_section.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenUserProfile extends StatefulWidget {
  const ScreenUserProfile({super.key});

  @override
  State<ScreenUserProfile> createState() => _ScreenUserProfileState();
}

class _ScreenUserProfileState extends State<ScreenUserProfile>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    context.read<LoginUserBloc>().add(LoginUserInitialFetchingEvent());
    context.read<FetchFollowingsBloc>().add(FetchFollowingInitialEvent());
    context.read<FetchFollowersBloc>().add(FetchFollowersInitialEvent());
    _tabController = TabController(length: 2, vsync: this);
    context.read<FetchPostBloc>().add(FetchPostInitialEvent());

    context.read<FetchSavedPostBloc>().add(FetchSavedpostInitialEvent());
  }

  final Debouncer debouncer = Debouncer(milliseconds: 500);
  Future<void> fetchDataProfileWithDebounce() async {
    await debouncer.run(() async {
      context.read<FetchFollowingsBloc>().add(FetchFollowingInitialEvent());
      context.read<FetchFollowersBloc>().add(FetchFollowersInitialEvent());
      context.read<FetchPostBloc>().add(FetchPostInitialEvent());
      context.read<LoginUserBloc>().add(LoginUserInitialFetchingEvent());
      context.read<FetchSavedPostBloc>().add(FetchSavedpostInitialEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double circleContainerSize = 130.0;

    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: fetchDataProfileWithDebounce,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    BlocConsumer<LoginUserBloc, LoginUserState>(
                      listener: (context, state1) {},
                      builder: (context, state1) {
                        if (state1 is LoginUserLoadingState) {
                          return Center(
                              child: LoadingAnimationWidget.fourRotatingDots(
                                  color: kpurpleMediumColor, size: 40));
                        } else if (state1 is LoginUserSuccessState) {
                          return Stack(
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
                                    image: NetworkImage(
                                        state1.loginuserdata.backGroundImage),
                                  ),
                                ),
                              ),
                              FollowersFollowingCard(
                                state1: state1,
                              ),
                              ProfilePicSection(
                                  profilepic: state1.loginuserdata.profilePic,
                                  size: size,
                                  circleContainerSize: circleContainerSize),
                            ],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(text: 'All Posts'),
                        Tab(text: 'Saved Posts'),
                      ],
                    ),
                    BlocBuilder<FetchPostBloc, FetchPostState>(
                      builder: (context, state) {
                        if (state is FetchPostLoadingState) {
                          return Center(
                              child: LoadingAnimationWidget.fourRotatingDots(
                                  color: kpurpleMediumColor, size: 40));
                        } else if (state is FetchPostSuccessState) {
                          return AutoScaleTabBarView(
                            controller: _tabController,
                            children: [
                              AllpostWidget(
                                state: state,
                              ),
                              BlocBuilder<FetchSavedPostBloc,
                                  FetchSavedPostState>(
                                builder: (context, state1) {
                                  if (state1 is FetchSavedpostLoadingState) {
                                    return Center(
                                        child: LoadingAnimationWidget
                                            .fourRotatingDots(
                                                color: kpurpleMediumColor,
                                                size: 40));
                                  } else if (state1
                                      is FetchSavedpostSuccessState) {
                                    return state1.savedposts.isEmpty
                                        ? Padding(
                                          padding: const EdgeInsets.all(30),
                                          child: Center(
                                              child: customtext(
                                                  'No Savedposts', 20,
                                                  textColor: kpurpleColor),
                                            ),
                                        )
                                        : GridView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount:
                                                  3, // Adjust for desired number of columns
                                              crossAxisSpacing: 5.0,
                                              mainAxisSpacing: 5.0,
                                            ),
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  navigatePush(context,
                                                      const SreenSavedPost());
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        state1.savedposts[index]
                                                            .postId.image,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: state1.savedposts.length,
                                          );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ],
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
          ),
        ]),
      ),
    );
  }
}
