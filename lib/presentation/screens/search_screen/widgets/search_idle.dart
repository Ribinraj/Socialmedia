// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:social_media_app/core/colors.dart';
// import 'package:social_media_app/core/constants.dart';
// import 'package:social_media_app/presentation/bloc/search_bloc/search_user_bloc.dart';
// import 'package:social_media_app/presentation/widgets/custom_round_image.dart';

// class SearchIdle extends StatefulWidget {
//   const SearchIdle({super.key});

//   @override
//   State<SearchIdle> createState() => _SearchIdleState();
// }

// class _SearchIdleState extends State<SearchIdle> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SearchUserBloc, SearchUserState>(
//       builder: (context, state) {
//         if (state is SearchUserLoadingState) {
//           return Center(
//             child: LoadingAnimationWidget.fourRotatingDots(
//                 color: kpurpleMediumColor, size: 40),
//           );
//         } else if (state is SearchUserSuccessState) {
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                   child: ListView.separated(
//                 shrinkWrap: true,
//                 separatorBuilder: (context, index) => kheight20,
//                 itemCount: state.searchuser.length,
//                 itemBuilder: (context, index) {
//                   return Row(
//                     children: [
//                       CustomRoundImage(
//                           circleContainerSize: 60,
//                           imageUrl: state.searchuser[index].profilePic),
//                       kwidth,
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             state.searchuser[index].userName,
//                             style: const TextStyle(
//                                 color: kpurpleColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16),
//                           ),
//                           Text(state.searchuser[index].bio ?? '',
//                               style: const TextStyle(
//                                   color: kpurpleColor,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 16),
//                               overflow: TextOverflow.ellipsis),
//                         ],
//                       ),
//                       const Spacer(),
//                       SizedBox(
//                           height: 35,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               //   navigatePush(
//                               // context,
//                               // ScreenProfile(
//                               //   id: followers[index].id,
//                               //   backgroundimage: followers[index].backGroundImage,
//                               //   profilepic: followers[index].profilePic,
//                               //   username: followers[index].userName,
//                               //   bio: followers[index].bio,
//                               // ));
//                             },
//                             style: ElevatedButton.styleFrom(
//                                 backgroundColor: kpurpledoublelightColor,
//                                 shape: const ContinuousRectangleBorder(),
//                                 fixedSize: const Size(120, 20),
//                                 side: const BorderSide(
//                                     color: kpurpleBorderColor, width: 1)),
//                             child: const Text(
//                               //     state2.followings.following.any((element) => element.id==followers[index].id)
//                               // ? 'Following'
//                               // : 'Followback',
//                               'Follow',
//                               style: TextStyle(fontSize: 13),
//                             ),
//                           )),
//                       kwidth
//                     ],
//                   );
//                 },
//               ))
//             ],
//           );
//         } else {
//           return const SizedBox();
//         }
//       },
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/search_bloc/search_user_bloc.dart';
import 'package:social_media_app/presentation/screens/search_screen/widgets/debouncer.dart';
import 'package:social_media_app/presentation/widgets/custom_round_image.dart';

class SearchIdle extends StatefulWidget {
  const SearchIdle({super.key});

  @override
  State<SearchIdle> createState() => _SearchIdleState();
}

class _SearchIdleState extends State<SearchIdle> {
  final TextEditingController searchcontroller = TextEditingController();
  final Debouncer debouncer = Debouncer(milliseconds: 500);
  @override
  Widget build(BuildContext context) {
    final search = context.read<SearchUserBloc>();
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SearchUserBloc, SearchUserState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: CupertinoSearchTextField(
                    controller: searchcontroller,
                    backgroundColor: kpurpleMediumColor.withOpacity(0.4),
                    prefixIcon: const Icon(
                      CupertinoIcons.search,
                      color: kpurpleBorderColor,
                    ),
                    suffixIcon: const Icon(CupertinoIcons.xmark_circle_fill,
                        color: kpurpleMediumColor),
                    style: const TextStyle(color: kpurpleColor),
                    onChanged: (value) {
                      debouncer.run(() {
                        search.add(SearchUserInitialEvent(
                            searchquery: searchcontroller.text));
                      });
                    },
                  ),
                  backgroundColor: kpurpledoublelightColor,
                ),
                if (state is SearchUserLoadingState)
                  SliverFillRemaining(
                    child: Center(
                      child: LoadingAnimationWidget.fourRotatingDots(
                        color: kpurpleMediumColor,
                        size: 40,
                      ),
                    ),
                  ),
                if (state is SearchUserSuccessState)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 5),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: kradius10,
                                color: kpurpledoublelightColor),
                            child: Row(
                              children: [
                                CustomRoundImage(
                                    circleContainerSize: 60,
                                    imageUrl:
                                        state.searchuser[index].profilePic),
                                kwidth,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.searchuser[index].userName,
                                        style: const TextStyle(
                                            color: kpurpleColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(state.searchuser[index].bio ?? '',
                                          style: const TextStyle(
                                              color: kpurpleColor,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                          overflow: TextOverflow.ellipsis),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Action for follow button
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kpurpledoublelightColor,
                                      shape: const ContinuousRectangleBorder(),
                                      side: const BorderSide(
                                          color: kpurpleBorderColor, width: 1)),
                                  child: const Text(
                                    'Follow',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                kwidth
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: state.searchuser.length,
                    ),
                  ),
                if (state is! SearchUserSuccessState &&
                    state is! SearchUserLoadingState)
                  const SliverFillRemaining(
                    child: Center(child: Text("Please Search User")),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
