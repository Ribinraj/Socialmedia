import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/data/models/followers_post.dart';
import 'package:social_media_app/presentation/bloc/followerspost/fetch_followerspost_bloc.dart';
import 'package:social_media_app/presentation/bloc/like_unlikepost/like_unlike_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';

import 'package:social_media_app/presentation/screens/home_screen/widgets/comment_sheet.dart';
import 'package:social_media_app/presentation/screens/home_screen/widgets/shimmer_homepage.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final likebloc = context.read<LikeUnlikePostBloc>();
    Size size = MediaQuery.of(context).size;
    const double circleContainerSize = 70;
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<FetchFollowerspostBloc, FetchFollowerspostState>(
          listener: (context, state) {
            if (state is FetchFollowersInternalErrorstate) {
              return customSnackbar(
                  context, 'internal Server Error', kredcolor);
            }
          },
          builder: (context, state) {
            if (state is FetchFollowersLoadingState) {
              return const Screenhomeshimmer();
            } else if (state is FetchFollowersSuccessState) {
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
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                kheight,
                                const CustomRoundImage(
                                    circleContainerSize: circleContainerSize,
                                    imageUrl:
                                        "https://stimg.cardekho.com/images/carexteriorimages/630x420/Mahindra/Thar/10745/1697697308167/front-left-side-47.jpg?imwidth=420&impolicy=resize"),
                                customHeadingtext('Jazim mpt', 13,
                                    fontWeight: FontWeight.w500,
                                    textColor: kblackColor)
                              ],
                            );
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            customHeadingtext(
                                                state.followersposts[index]
                                                    .userId.userName,
                                                18,
                                                textColor: kblackColor,
                                                fontWeight: FontWeight.bold),
                                            customstyletext(
                                                timeago.format(state
                                                    .followersposts[index]
                                                    .createdAt),
                                                15,
                                                textColor: kgreycolor)
                                          ],
                                        ),
                                        kwidth30,
                                        state.followersposts[index].createdAt !=
                                                state.followersposts[index]
                                                    .updatedAt
                                            ? customstyletext('Edited', 15,
                                                textColor: kgreycolor)
                                            : const SizedBox(),
                                        const Spacer(),
                                        PopupMenuButton<String>(
                                          onSelected: (value) {
                                            if (value == 'Save') {
                                            } else if (value == 'Report') {}
                                          },
                                          itemBuilder: (BuildContext context) =>
                                              [
                                            const PopupMenuItem(
                                              value: 'Save',
                                              child: Text('Save'),
                                            ),
                                            const PopupMenuItem(
                                              value: 'Report',
                                              child: Text('Report'),
                                            ),
                                          ],
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
                                              IconButton(
                                                  onPressed: () {
                                                    if (state
                                                            .followersposts[
                                                                index]
                                                            .isLiked ==
                                                        false) {
                                                      state
                                                          .followersposts[index]
                                                          .isLiked = true;
                                                      state
                                                          .followersposts[index]
                                                          .likes
                                                          .add(UserId.fromJson(
                                                              state2
                                                                  .loginuserdata
                                                                  .toJson()));
                                                      likebloc.add(LikepostEvent(
                                                          postid: state
                                                              .followersposts[
                                                                  index]
                                                              .id));
                                                    } else {
                                                      state
                                                          .followersposts[index]
                                                          .isLiked = false;
                                                      state
                                                          .followersposts[index]
                                                          .likes
                                                          .removeWhere((element) =>
                                                              element.id ==
                                                              state2
                                                                  .loginuserdata
                                                                  .id);
                                                      likebloc.add(
                                                          UnlikePostEvent(
                                                              postid: state
                                                                  .followersposts[
                                                                      index]
                                                                  .id));
                                                    }
                                                  },
                                                  icon: Icon(Icons.favorite,
                                                      color: state
                                                                  .followersposts[
                                                                      index]
                                                                  .isLiked ==
                                                              true
                                                          ? kredcolor
                                                          : kwhiteColor)),
                                              customHeadingtext(
                                                  '${state.followersposts[index].likes.length} ',
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
                                              IconButton(
                                                  onPressed: () {
                                                    showModalBottomSheet(
                                                      context: context,
                                                      isScrollControlled:
                                                          true, // Enable scrolling
                                                      builder: (BuildContext
                                                          context) {
                                                        return DraggableScrollableSheet(
                                                          initialChildSize:
                                                              0.5, // Set initial size of the sheet
                                                          minChildSize:
                                                              0.25, // Set minimum size of the sheet
                                                          maxChildSize:
                                                              1.0, // Set maximum size of the sheet
                                                          expand: false,
                                                          builder: (BuildContext
                                                                  context,
                                                              ScrollController
                                                                  scrollController) {
                                                            return CommentPage(
                                                                scrollController:
                                                                    scrollController,postId: state.followersposts[index].id,);
                                                            // Pass the scroll controller to your CommentPage widget if needed
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                  icon: const Icon(
                                                      Icons.comment)),
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
//class MainCardContainer extends StatelessWidget {
//   const MainCardContainer({
//     super.key,
//     required this.size,
//     required  this.state
//   });

//   final Size size;
//   final FetchPostSuccessState state;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(
//         top: 10,
//         left: 5,
//         right: 5,
//       ),
//       height: 550,
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: kpurpledoublelightColor, borderRadius: kradius10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               const CustomRoundImage(
//                   circleContainerSize: 45,
//                   imageUrl:
//                       "https://i.pinimg.com/736x/d0/4b/1f/d04b1f2ed3ca8ad4a302fbe9f4f5a875.jpg"),
//               kwidth,
//               Column(
//                 children: [
//                   customHeadingtext(state.posts[index].userId.userName, 18,
//                       textColor: kblackColor, fontWeight: FontWeight.bold),
//                   customstyletext('11 hours ago', 15, textColor: kgreycolor)
//                 ],
//               )
//             ],
//           ),
//           kheight,
//           Container(
//             width: size.width,
//             height: 375,
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: NetworkImage(state.posts[index].image),
//                 ),
//                 borderRadius: kradius10),
//           ),
//           kheight,
//           SizedBox(
//             height: 50,
//             child: customHeadingtext(
//               state.posts[index].description,
//               16,
//               textColor: kblackColor,
//             ),
//           ),
//           Row(
//             children: [
//               IconButton(
//                   onPressed: () {},
//                   icon: const Icon(
//                     Icons.favorite,
//                     color: kredcolor,
//                   )),
//               customHeadingtext('${state.posts[index].likes.length}', 15,
//                   textColor: kblackColor),
//               kwidth,
//               IconButton(onPressed: () {}, icon: const Icon(Icons.comment)),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
//shimmer
