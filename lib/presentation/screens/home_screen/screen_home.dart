import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/fetchpost/fetch_post_bloc.dart';
import 'package:social_media_app/presentation/widgets/custom_round_image.dart';
import 'package:social_media_app/presentation/widgets/custom_snakbar.dart';
import 'package:social_media_app/presentation/widgets/shared_preferences.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    context.read<FetchPostBloc>().add(FetchPostInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double circleContainerSize = 70;
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<FetchPostBloc, FetchPostState>(
          listener: (context, state) {
            if (state is FetchPostErrorStateInternalserverError) {
              return customSnackbar(
                  context, 'internal Server Error', kredcolor);
            }
          },
          builder: (context, state) {
            if (state is FetchPostLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kpurpleBorderColor,
                ),
              );
            } else if (state is FetchPostSuccessState) {
              return NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, bool isScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor: kpurpledoublelightColor,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomRoundImage(
                            circleContainerSize: 44,
                            imageUrl:
                                "https://stimg.cardekho.com/images/carexteriorimages/630x420/Mahindra/Thar/10745/1697697308167/front-left-side-47.jpg?imwidth=420&impolicy=resize",
                          ),
                          customHeadingtext('Junction', 25,
                              fontWeight: FontWeight.w800,
                              textColor: kpurpleColor),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  final value = await getUserToken();
                                  print(value);
                                },
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
                        itemCount: state.posts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 5,
                                right: 5,
                              ),
                              height: 550,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: kpurpledoublelightColor,
                                  borderRadius: kradius10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const CustomRoundImage(
                                          circleContainerSize: 45,
                                          imageUrl:
                                              "https://i.pinimg.com/736x/d0/4b/1f/d04b1f2ed3ca8ad4a302fbe9f4f5a875.jpg"),
                                      kwidth,
                                      Column(
                                        children: [
                                          customHeadingtext(
                                              state
                                                  .posts[index].userId.userName,
                                              18,
                                              textColor: kblackColor,
                                              fontWeight: FontWeight.bold),
                                          customstyletext('11 hours ago', 15,
                                              textColor: kgreycolor)
                                        ],
                                      )
                                    ],
                                  ),
                                  kheight,
                                  Container(
                                    width: size.width,
                                    height: 375,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              state.posts[index].image),
                                        ),
                                        borderRadius: kradius10),
                                  ),
                                  kheight,
                                  SizedBox(
                                    height: 50,
                                    child: customHeadingtext(
                                      state.posts[index].description,
                                      16,
                                      textColor: kblackColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.favorite,
                                            color: kredcolor,
                                          )),
                                      customHeadingtext(
                                          '${state.posts[index].likes.length}',
                                          15,
                                          textColor: kblackColor),
                                      kwidth,
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons.comment)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
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
