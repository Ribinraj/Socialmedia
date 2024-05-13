
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/data/models/following_model.dart';
import 'package:social_media_app/presentation/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetch_following.dart/fetch_followings_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchall_conversation/fetchall_conversation_bloc.dart';
import 'package:social_media_app/presentation/screens/chat_screen.dart/individual_chatpage.dart';
import 'package:social_media_app/presentation/screens/home_screen/screen_home.dart';

import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:social_media_app/presentation/widgets/custom_round_image.dart';


import 'package:social_media_app/presentation/widgets/tex.dart';
import 'package:multi_bloc_builder/builders/multi_bloc_builder.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  
  @override
  void initState() {
    super.initState();
   
    context.read<FetchFollowingsBloc>().add(FetchFollowingInitialEvent());
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: kpurpleColor,
            title: customHeadingtext('Create New Chat', 25)),
        body: MultiBlocBuilder(
            blocs: [
              context.watch<FetchFollowingsBloc>(),
              context.watch<ConversationBloc>()
            ],
            builder: (context, state) {
              var state1 = state[0];
              var state2 = state[1];
              if (state1 is FetchFollowingLoadingState) {
                return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                      color: kpurpleMediumColor, size: 40),
                );
              } else if (state1 is FetchFollowingSuccessState) {
                final FollowingModel followings = state1.followings;
                return followings.following.isEmpty
                    ? const Center(
                        child: Text('no followes'),
                      )
                    : ListView.builder(
                        itemCount: followings.totalCount,
                        itemBuilder: (context, index) {
                          final Following following =
                              followings.following[index];
                          return GestureDetector(
                            onTap: () {
                              context.read<ConversationBloc>().add(
                                  CreateConversationButtonClickEvent(
                                      members: [loginuserid, following.id]));
                              if (state2 is ConversationSuccessState) {
                                context
                                    .read<FetchallConversationBloc>()
                                    .add(AllConversationsInitialFetchEvent());
                                navigatePush(
                                    context,
                                    IndividualChatPage(
                                        conversationId: state2.convrsationId,
                                        receiverid: following.id,
                                        name: following.userName,
                                        profilepic: following.profilePic));
                              }
                            },
                            child: ListTile(
                              leading: CustomRoundImage(
                                  circleContainerSize: 50,
                                  imageUrl: following.profilePic),
                              title: Text(
                                following.userName,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                following.bio ?? '',
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          );
                        },
                      );
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}
