import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:social_media_app/core/colors.dart';

import 'package:social_media_app/data/models/following_model.dart';
import 'package:social_media_app/presentation/bloc/fetch_following.dart/fetch_followings_bloc.dart';
import 'package:social_media_app/presentation/bloc/follow_unfollow/follow_unfollow_bloc.dart';
import 'package:social_media_app/presentation/bloc/suggession_bloc/suggession_users_bloc.dart';
import 'package:social_media_app/presentation/screens/profile_screen/profile_screen.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:social_media_app/presentation/widgets/custom_round_image.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({Key? key}) : super(key: key);

  @override
  State<FollowingScreen> createState() => FollowingScreenState();
}

class FollowingScreenState extends State<FollowingScreen> {
  @override
  void initState() {
    context.read<FetchFollowingsBloc>().add(FetchFollowingInitialEvent());
    super.initState();
  }

  List<Following> following = [];

  @override
  Widget build(BuildContext context) {
    final unfollow = context.read<FollowUnfollowBloc>();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: kwhiteColor,
            )),
        backgroundColor: kpurpleColor,
        title: customHeadingtext('Followings', 25),
        centerTitle: true,
      ),
      body: MultiBlocConsumer(
        blocs: [
          context.watch<FetchFollowingsBloc>(),
          context.watch<FollowUnfollowBloc>()
        ],
        buildWhen: null,
        listener: (context, state) {
          // var state1 = state[0];
          var state2 = state[1];
          if (state2 is UnfollowuserSuccessState) {
            context
                .read<SuggessionUsersBloc>()
                .add(SuggessionUsersInitialEvent());
          }
        },
        builder: (context, state) {
          var state1 = state[0];
          //  var state2 = state[1];
          if (state[0] is FetchFollowingLoadingState) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: kpurpleMediumColor, size: 40),
            );
          } else if (state1 is FetchFollowingSuccessState) {
            following = state1.followings.following;
            return following.isEmpty
                ? Center(
                    child:
                        customtext('No folloings', 20, textColor: kpurpleColor),
                  )
                : ListView.builder(
                    itemCount: following.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: InkWell(
                          onTap: () {
                            navigatePush(
                                context,
                                ScreenProfile(
                                  id: following[index].id,
                                  backgroundimage:
                                      following[index].backGroundImage,
                                  profilepic: following[index].profilePic,
                                  username: following[index].userName,
                                  bio: following[index].bio,
                                ));
                          },
                          child: CustomRoundImage(
                              circleContainerSize: 50,
                              imageUrl: following[index].profilePic),
                        ),
                        title: Text(following[index].userName),
                        trailing: SizedBox(
                          height: 35,
                          child: ElevatedButton(
                            onPressed: () {
                              unfollow.add(UnFollowButtonClickEvent(
                                  unfolloweeId: following[index].id));

                              following.removeWhere((element) =>
                                  element.id == following[index].id);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kpurpledoublelightColor,
                                shape: const ContinuousRectangleBorder(),
                                fixedSize: const Size(105, 20),
                                side: const BorderSide(
                                    color: kpurpleBorderColor, width: 1)),
                            child: const Text(
                              'Unfollow',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
