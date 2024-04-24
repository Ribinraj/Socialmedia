import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';

import 'package:social_media_app/presentation/widgets/tex.dart';

class ShimmerCommentPage extends StatefulWidget {
  final ScrollController scrollController;

  const ShimmerCommentPage({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<ShimmerCommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<ShimmerCommentPage> {
  final textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextField for entering comments
            kheight20,
            SizedBox(
              height: 50,
              child: TextField(
                controller: textcontroller,
                decoration: InputDecoration(
                  hintText: 'Write a comment...',

                  border: const OutlineInputBorder(),
                  // Add an icon button after the text field
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      color: kpurpleColor,
                    ), // You can use any icon you want
                  ),
                ),
              ),
            ),
            kheight,
            // Comments display
            customHeadingtext('Comments', 25,
                fontWeight: FontWeight.bold, textColor: kpurpleColor),
            const SizedBox(height: 10),

            SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              child: ListView.builder(
                // controller: widget.scrollController,
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Container(
                    color: kwhiteColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Shimmer(
                            gradient: LinearGradient(colors: [
                              kpurpleMediumColor,
                              kpurplelightColor
                            ]),
                            child: CircleAvatar(
                              radius: 20,
                            ),
                          ),
                          kwidth,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                              kheight20,
                              Shimmer(
                                gradient: const LinearGradient(colors: [
                                  kpurpleMediumColor,
                                  kpurplelightColor
                                ]),
                                child: Container(
                                  width: 200,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: kradius10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
