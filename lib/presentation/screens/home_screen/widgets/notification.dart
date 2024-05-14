import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/presentation/bloc/bloc/get_notification_bloc.dart';

import 'package:social_media_app/presentation/screens/profile_screen/profile_screen.dart';
import 'package:social_media_app/presentation/screens/search_screen/widgets/debouncer.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:social_media_app/presentation/widgets/custom_round_image.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();
    context.read<GetNotificationBloc>().add(GetnotificationInitialEvent());
  }
 final Debouncer debouncer = Debouncer(milliseconds: 500);

  Future<void> fetchDataWithDebounceNotification() async {
    await debouncer.run(() async {
       context.read<GetNotificationBloc>().add(GetnotificationInitialEvent());
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kpurpledoublelightColor,
        appBar: AppBar(
          leading:  GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: kwhiteColor,
            )),
          backgroundColor: kpurpleColor,
          centerTitle: true,
          title:
              const Text('Notifications', style: TextStyle(color: kwhiteColor)),
        ),
        body: BlocBuilder<GetNotificationBloc, GetNotificationState>(
          builder: (context, state) {
            if (state is GetNotificationLoadingState) {
              return Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: kpurpleMediumColor, size: 40),
              );
            } else if (state is GetNotificationSuccessState) {
              return RefreshIndicator(
                onRefresh: fetchDataWithDebounceNotification,
                child: ListView.builder(
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = state.notifications[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              navigatePush(context, ScreenProfile(id: notification.from.id, backgroundimage: notification.from.backGroundImage!, profilepic:notification.from.profilePic!, username:notification.from.userName));
                            },
                            child: CustomRoundImage(
                                circleContainerSize: 45,
                                imageUrl:
                                    state.notifications[index].from.profilePic!),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(notification.from.userName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  notification.message,
                                  style: const TextStyle(color: kblackColor),
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
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
