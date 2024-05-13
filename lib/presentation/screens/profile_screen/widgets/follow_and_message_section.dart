
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchall_conversation/fetchall_conversation_bloc.dart';
import 'package:social_media_app/presentation/bloc/follow_unfollow/follow_unfollow_bloc.dart';
import 'package:social_media_app/presentation/bloc/suggession_bloc/suggession_users_bloc.dart';
import 'package:social_media_app/presentation/screens/chat_screen.dart/individual_chatpage.dart';
import 'package:social_media_app/presentation/screens/home_screen/screen_home.dart';
import 'package:social_media_app/presentation/screens/profile_screen/profile_screen.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:social_media_app/presentation/widgets/custom_profile_button.dart';

class FollowAndMessageSection extends StatelessWidget {
  const FollowAndMessageSection({
    super.key,
    required this.widget,
    required this.followUnfollow,
  });

  final ScreenProfile widget;
  final FollowUnfollowBloc followUnfollow;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BlocConsumer<FollowUnfollowBloc,
            FollowUnfollowState>(
          listener: (context, state) {
            if (state is FollowuserSuccessState) {
              context.read<FollowUnfollowBloc>().add(
                  IsfollowingInitialEvent(
                      userId: widget.id));
              context
                  .read<SuggessionUsersBloc>()
                  .add(SuggessionUsersInitialEvent());
            } else if (state
                is UnfollowuserSuccessState) {
              context.read<FollowUnfollowBloc>().add(
                  IsfollowingInitialEvent(
                      userId: widget.id));
              context
                  .read<SuggessionUsersBloc>()
                  .add(SuggessionUsersInitialEvent());
            }
          },
          builder: (context, state) {
            if (state is IsfollowingSuccessState) {
              bool isfollowing = state.isfollowing;
              return CustomProfilebutton(
                  onPressed: () {
                    if (isfollowing == false) {
                      isfollowing = true;
                      followUnfollow.add(
                          FollowButtonClickEvent(
                              followeeId: widget.id));
                    } else {
                      isfollowing = false;
                      followUnfollow.add(
                          UnFollowButtonClickEvent(
                              unfolloweeId: widget.id));
                    }
                  },
                  buttonText: isfollowing == false
                      ? 'Follow'
                      : 'Unfollow');
            } else {
              return CustomProfilebutton(
                  onPressed: () {}, buttonText: '');
            }
          },
        ),
        kwidth20,
        BlocConsumer<ConversationBloc, ConversationState>(
          listener: (context, state) {
            if (state is ConversationSuccessState) {
              print('inside created conversation');
              context.read<FetchallConversationBloc>().add(
                  AllConversationsInitialFetchEvent());
              navigatePush(
                  context,
                  IndividualChatPage(
                      conversationId: state.convrsationId,
                      receiverid: widget.id,
                      name: widget.username,
                      profilepic: widget.profilepic));
            }
          },
          builder: (context, state) {
            return CustomProfilebutton(
                onPressed: () {
                  context.read<ConversationBloc>().add(
                          CreateConversationButtonClickEvent(
                              members: [
                            loginuserid,
                            widget.id
                          ]));
                },
                buttonText: 'Message');
          },
        )
      ],
    );
  }
}
