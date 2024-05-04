import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/data/models/comments_model.dart';

import 'package:social_media_app/presentation/bloc/add_comment/add_comment_bloc.dart';
import 'package:social_media_app/presentation/bloc/cmment_delete/comment_delete_bloc.dart';

import 'package:social_media_app/presentation/bloc/fetchcomment/fetch_comment_bloc.dart';
import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';
import 'package:social_media_app/presentation/screens/home_screen/widgets/shimmer_commentpage.dart';
import 'package:social_media_app/presentation/widgets/custom_round_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:social_media_app/presentation/widgets/tex.dart';

class CommentPage extends StatefulWidget {
  final String postId;
  final LoginUserSuccessState state2;
  final ScrollController scrollController;

  const CommentPage(
      {Key? key,
      required this.scrollController,
      required this.postId,
      required this.state2})
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
    final userdata = widget.state2.loginuserdata;
    final addcomment = context.read<AddCommentBloc>();
    final deletecomment = context.read<CommentDeleteBloc>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<FetchCommentBloc, FetchCommentState>(
          builder: (context, state) {
            if (state is FetchCommentLoadingState) {
              return ShimmerCommentPage(
                  scrollController: widget.scrollController);
            } else if (state is FetchCommentSuccessState) {
              return Container(
                color: kpurpledoublelightColor,
                padding: const EdgeInsets.all(10),
                child: BlocBuilder<AddCommentBloc, AddCommentState>(
                  builder: (context, state1) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // TextField for entering comments
                        kheight20,

                        SizedBox(
                          height: 80,
                          child: TextField(
                            maxLines:
                                null, // Allows the text field to expand vertically.
                            keyboardType: TextInputType.multiline,
                            controller: textcontroller,
                            decoration: InputDecoration(
                              hintText: 'Write a comment...',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  addcomment.add(AddCommentClickEvent(
                                      userId: userdata.id,
                                      userName: userdata.userName,
                                      postId: widget.postId,
                                      content: textcontroller.text));
                                  state.comments.add(CommentModel(
                                      id: widget.postId,
                                      user: CommentUser(
                                          id: userdata.id,
                                          userName: userdata.userName,
                                          profilePic: userdata.profilePic),
                                      content: textcontroller.text,
                                      createdAt: DateTime.now()));
                                  textcontroller.clear();
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

                        customHeadingtext('Comments', 25,
                            fontWeight: FontWeight.bold,
                            textColor: kpurpleColor),
                        const SizedBox(height: 10),

                        BlocBuilder<CommentDeleteBloc, CommentDeleteState>(
                          builder: (context, state2) {
                            return Expanded(
                              child: ListView.builder(
                                controller: widget.scrollController,
                                itemCount: state.comments.length,
                                itemBuilder: (context, index) {
                                  final comment = state.comments[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      textColor: kblackColor),
                                                  const Spacer(),
                                                  Text(
                                                    timeago.format(
                                                        comment.createdAt),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        color: kgreycolor),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Text(
                                                          comment.content)),
                                                  comment.user.id == userdata.id
                                                      ? IconButton(
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: const Text(
                                                                      'Are you sure?'),
                                                                  actions: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        // Close the dialog
                                                                         deletecomment.add(CommentDeleteClickEvent(
                                                                            commentId:
                                                                                comment.id));
                                                                        state.comments.removeWhere((element) =>
                                                                            element.id ==
                                                                            comment.id);
                                                                             Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text(
                                                                          'Yes'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                     
                                                                        Navigator.pop(
                                                                            context); // Close the dialog
                                                                      },
                                                                      child: const Text(
                                                                          'No'),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          icon: const Icon(
                                                            Icons.delete,
                                                            color:
                                                                kpurpleMediumColor,
                                                            size: 18,
                                                          ))
                                                      : const SizedBox()
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
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
