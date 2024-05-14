import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';
import 'package:social_media_app/presentation/screens/chat_screen.dart/chatpage.dart';
import 'package:social_media_app/presentation/screens/home_screen/widgets/notification.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:social_media_app/presentation/widgets/custom_round_image.dart';
import 'package:social_media_app/presentation/widgets/titlelogo.dart';

class AppbarSection extends StatelessWidget {
  const AppbarSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: kpurpleColor,
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
          titlelogo(),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  navigatePush(context, const Chatpage());
                },
                icon: const Icon(
                  Icons.chat_outlined,
                  color: kwhiteColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  navigatePush(context, const NotificationPage());
                },
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
    );
  }
}
