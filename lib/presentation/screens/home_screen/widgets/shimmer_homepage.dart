import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';

import 'package:social_media_app/presentation/widgets/titlelogo.dart';

class Screenhomeshimmer extends StatelessWidget {
  const Screenhomeshimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, bool isScrolled) {
            return [
              SliverAppBar(
                backgroundColor: kpurpleColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Shimmer(
                      gradient: LinearGradient(
                          colors: [kpurpleMediumColor, kpurplelightColor]),
                      child: CircleAvatar(
                        radius: 27,
                      ),
                    ),
                    titlelogo(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.chat_outlined,
                            color: kwhiteColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_outlined,
                            size: 28,
                            color: kwhiteColor,
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
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Shimmer(
                    gradient: LinearGradient(
                        colors: [kpurpleMediumColor, kpurplelightColor]),
                    child: SizedBox(
                      height: 20,
                    ),
                  ),
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
                      return const Column(
                        children: [
                          kheight,
                          Shimmer(
                            gradient: LinearGradient(colors: [
                              kpurpleMediumColor,
                              kpurplelightColor
                            ]),
                            child: CircleAvatar(
                              radius: 37,
                            ),
                          ),
                          Shimmer(
                            gradient: LinearGradient(colors: [
                              kpurpleMediumColor,
                              kpurplelightColor
                            ]),
                            child: SizedBox(
                              height: 20,
                            ),
                          )
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
                  itemCount: 20,
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
                                const Shimmer(
                                  gradient: LinearGradient(colors: [
                                    kpurpleMediumColor,
                                    kpurplelightColor
                                  ]),
                                  child: CircleAvatar(
                                    radius: 30,
                                  ),
                                ),
                                kwidth,
                                Column(
                                  children: [
                                    Shimmer(
                                      gradient: const LinearGradient(colors: [
                                        kpurpleMediumColor,
                                        kpurplelightColor
                                      ]),
                                      child: Container(
                                        width: 200,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          borderRadius: kradius10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Shimmer(
                                      gradient: const LinearGradient(colors: [
                                        kpurpleMediumColor,
                                        kpurplelightColor
                                      ]),
                                      child: Container(
                                        width: 200,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          borderRadius: kradius10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            kheight,
                            Shimmer(
                              gradient: const LinearGradient(colors: [
                                kpurpleMediumColor,
                                kpurplelightColor
                              ]),
                              child: Container(
                                width: size.width,
                                height: 375,
                                decoration: BoxDecoration(
                                  borderRadius: kradius10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            kheight,
                            Shimmer(
                              gradient: const LinearGradient(colors: [
                                kpurpleMediumColor,
                                kpurplelightColor
                              ]),
                              child: Container(
                                width: size.width,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: kradius10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: kpurpleMediumColor,
                                    )),
                                Container(
                                  height: 10,
                                ),
                                kwidth,
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.comment,
                                      color: kpurpleMediumColor,
                                    )),
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
        ),
      ),
    );
  }
}
