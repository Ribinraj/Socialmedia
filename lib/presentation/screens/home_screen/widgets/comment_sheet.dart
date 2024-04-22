import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/fetchcomment/fetch_comment_bloc.dart';
import 'package:social_media_app/presentation/widgets/custom_round_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media_app/presentation/widgets/tex.dart';

class CommentPage extends StatefulWidget {
  final String postId;
  final ScrollController scrollController;

  const CommentPage(
      {Key? key, required this.scrollController, required this.postId})
      : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  void initState() {
    context
        .read<FetchCommentBloc>()
        .add(FetchCommentInitialEvent(postId: widget.postId));
    super.initState();
  }

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
                  decoration: InputDecoration(
                    hintText: 'Write a comment...',
                    border: const OutlineInputBorder(),
                    // Add an icon button after the text field
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Add your action here when the icon button is pressed
                      },
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
              BlocBuilder<FetchCommentBloc, FetchCommentState>(
                builder: (context, state) {
                  if (state is FetchCommentLoadingState) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * .3,
                      child: ListView.builder(
                        // controller: widget.scrollController,
                        itemCount: 5,
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
                                      radius: 37,
                                    ),
                                  ),
                                  kwidth,
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                    );
                  } else if (state is FetchCommentSuccessState) {
                    return Expanded(
                      child: ListView.builder(
                        controller: widget.scrollController,
                        itemCount: state.comments.length,
                        itemBuilder: (context, index) {
                          final comment = state.comments[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomRoundImage(
                                    circleContainerSize: 50,
                                    imageUrl: comment.user.profilePic),
                                kwidth,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          customHeadingtext(
                                              comment.user.userName, 17,
                                              fontWeight: FontWeight.w500,
                                              textColor: kblackColor),
                                          const Spacer(),
                                          Text(
                                            timeago.format(comment.createdAt),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: kgreycolor),
                                          ),
                                        ],
                                      ),
                                      Text(comment.content),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
