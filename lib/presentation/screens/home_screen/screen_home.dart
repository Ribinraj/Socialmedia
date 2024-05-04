import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/presentation/bloc/followerspost/fetch_followerspost_bloc.dart';
import 'package:social_media_app/presentation/bloc/like_unlikepost/like_unlike_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';

import 'package:social_media_app/presentation/bloc/saved_post/saved_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/suggession_bloc/suggession_users_bloc.dart';
import 'package:social_media_app/presentation/screens/home_screen/widgets/favourit_section.dart';

import 'package:social_media_app/presentation/screens/home_screen/widgets/comment_section.dart';
import 'package:social_media_app/presentation/screens/home_screen/widgets/postusernamesession.dart';
import 'package:social_media_app/presentation/screens/home_screen/widgets/report_and_savedpost.dart';

import 'package:social_media_app/presentation/screens/home_screen/widgets/shimmer_homepage.dart';

import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/screens/profile_screen/profile_screen.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';

import 'package:social_media_app/presentation/widgets/custom_round_image.dart';
import 'package:social_media_app/presentation/widgets/custom_snakbar.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int currentPage = 1;
  void _loadMore() {
    context.read<FetchFollowerspostBloc>().add(LoadMoreFollowersPostsEvent());
  }

  @override
  void initState() {
    context
        .read<FetchFollowerspostBloc>()
        .add(InitialFetchingEventFollowersPost(n: currentPage));
    context.read<SuggessionUsersBloc>().add(SuggessionUsersInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final likebloc = context.read<LikeUnlikePostBloc>();
    final savedbloc = context.read<SavedPostBloc>();

    Size size = MediaQuery.of(context).size;
    const double circleContainerSize = 70;
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<FetchFollowerspostBloc, FetchFollowerspostState>(
          listener: (context, state) {
            if (state is FetchFollowersPostInternalErrorstate) {
              return customSnackbar(
                  context, 'internal Server Error', kredcolor);
            }
          },
          builder: (context, state) {
            if (state is FetchFollowersPostLoadingState) {
              return const Screenhomeshimmer();
            } else if (state is FetchFollowersPostSuccessState) {
              return NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, bool isScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: kpurpledoublelightColor,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<LoginUserBloc, LoginUserState>(
                            builder: (context, state1) {
                              if (state1 is LoginUserSuccessState) {
                                return CustomRoundImage(
                                  circleContainerSize: 44,
                                  imageUrl: state1.loginuserdata.profilePic,
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                          customHeadingtext('Junction', 25,
                              fontWeight: FontWeight.w800,
                              textColor: kpurpleColor),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.chat_outlined,
                                  color: kpurpleColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.notifications_outlined,
                                  size: 28,
                                  color: kpurpleColor,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      floating: true,
                      toolbarHeight: 60,
                    )
                  ];
                },
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: customHeadingtext('Suggestions', 17,
                            fontWeight: FontWeight.w500,
                            textColor: kpurpleColor),
                      ),
                      LimitedBox(
                        maxHeight: 110,
                        child: BlocBuilder<SuggessionUsersBloc,
                            SuggessionUsersState>(
                          builder: (context, state3) {
                            if (state3 is SuggessionUsersSuccessState) {
                              return ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 10),
                                itemCount: state3.suggessions.data.length,
                                itemBuilder: (context, index) {
                                  final details =
                                      state3.suggessions.data[index];
                                  return Column(
                                    children: [
                                      kheight,
                                      InkWell(
                                        onTap: () {
                                          navigatePush(
                                              context,
                                              ScreenProfile(id: details.id, backgroundimage: details.backGroundImage, profilepic: details.profilePic, username:details.userName,bio: details.bio,));
                                        },
                                        child: CustomRoundImage(
                                            circleContainerSize:
                                                circleContainerSize,
                                            imageUrl: state3.suggessions
                                                .data[index].profilePic),
                                      ),
                                      customHeadingtext(
                                          state3
                                              .suggessions.data[index].userName,
                                          13,
                                          fontWeight: FontWeight.w500,
                                          textColor: kblackColor)
                                    ],
                                  );
                                },
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                      ),
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: state.followersposts.length + 1,
                        itemBuilder: (context, index) {
                          if (index == state.followersposts.length) {
                            return Visibility(
                              visible: state.followersposts.length % 5 == 0,
                              child: TextButton(
                                onPressed: _loadMore,
                                child: const Text('Load More'),
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  left: 5,
                                  right: 5,
                                ),
                                height: 515,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: kpurpledoublelightColor,
                                    borderRadius: kradius10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CustomRoundImage(
                                            circleContainerSize: 45,
                                            imageUrl: state
                                                .followersposts[index]
                                                .userId
                                                .profilePic),
                                        kwidth,
                                        PostUsernameSection(
                                          state: state,
                                          index: index,
                                        ),
                                        kwidth30,
                                        const Spacer(),
                                        ReportAndSavedPost(
                                          savedbloc: savedbloc,
                                          state: state,
                                          index: index,
                                        )
                                      ],
                                    ),
                                    kheight,
                                    Container(
                                      width: size.width,
                                      height: 335,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(state
                                                .followersposts[index].image),
                                          ),
                                          borderRadius: kradius10),
                                    ),
                                    kheight,
                                    SizedBox(
                                      height: 50,
                                      child: customHeadingtext(
                                        state.followersposts[index].description,
                                        16,
                                        textColor: kblackColor,
                                      ),
                                    ),
                                    MultiBlocBuilder(
                                      blocs: [
                                        context.watch<LikeUnlikePostBloc>(),
                                        context.watch<LoginUserBloc>(),
                                      ],
                                      builder: (context, states) {
                                        //var state1 = states[0];
                                        var state2 = states[1];
                                        if (state2 is LoginUserSuccessState) {
                                          return Row(
                                            children: [
                                              FavouriteSection(
                                                  state: state,
                                                  index: index,
                                                  state2: state2,
                                                  likebloc: likebloc),
                                              customHeadingtext(
                                                  '${state.followersposts[index].likes.length}',
                                                  15,
                                                  fontWeight: FontWeight.w500,
                                                  textColor: kblackColor),
                                              state.followersposts[index].likes
                                                          .length >
                                                      1
                                                  ? customHeadingtext(
                                                      'Likes', 15,
                                                      textColor: kblackColor)
                                                  : customHeadingtext(
                                                      'Like', 15,
                                                      textColor: kblackColor),
                                              kwidth,
                                              CommentWidget(
                                                
                                                state2: state2,
                                                postId: state.followersposts[index].id
                                              ),
                                            ],
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
