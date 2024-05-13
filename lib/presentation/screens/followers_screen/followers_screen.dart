import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:multi_bloc_builder/multi_bloc_builder.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/data/models/followers_model.dart';

import 'package:social_media_app/presentation/bloc/fetch_followers/fetch_followers_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetch_following.dart/fetch_followings_bloc.dart';
import 'package:social_media_app/presentation/screens/profile_screen/profile_screen.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';



import 'package:social_media_app/presentation/widgets/custom_round_image.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({Key? key}) : super(key: key);

  @override
  State<FollowersScreen> createState() => FollowersScreenState();
}

class FollowersScreenState extends State<FollowersScreen> {
  List<Follower> followers = [];
  @override
  void initState() {
    context.read<FetchFollowersBloc>().add(FetchFollowersInitialEvent());
    context.read<FetchFollowingsBloc>().add(FetchFollowingInitialEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kpurpleColor,
        leading:  GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: kwhiteColor,
            )),
        title: customHeadingtext('Followers', 25),
        centerTitle: true,
      ),
      body: MultiBlocConsumer(
        blocs: [
          context.watch<FetchFollowersBloc>(),
          context.watch<FetchFollowingsBloc>()
        ],
        buildWhen: null,
        listener: (context, state) {
    
        },
        builder: (context, state) {
          var state1 = state[0];
          var state2 = state[1];
          if (state[0] is FetchFollowersLoadingState) {
            return Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                  color: kpurpleMediumColor, size: 40),
            );
          } else if (state1 is FetchFollowersSuccessState &&
              state2 is FetchFollowingSuccessState) {
            followers = state1.followers.followers;
            return ListView.builder(
              itemCount: followers.length,
              itemBuilder: (context, index) {
           
                return ListTile(
                  leading: CustomRoundImage(
                      circleContainerSize: 50,
                      imageUrl: followers[index].profilePic),
                  title: Text(followers[index].userName),
                  trailing: SizedBox(
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                            navigatePush(
                          context,
                          ScreenProfile(
                            id: followers[index].id,
                            backgroundimage: followers[index].backGroundImage,
                            profilepic: followers[index].profilePic,
                            username: followers[index].userName,
                            bio: followers[index].bio,
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kpurpledoublelightColor,
                            shape: const ContinuousRectangleBorder(),
                            fixedSize: const Size(120, 20),
                            side: const BorderSide(
                                color: kpurpleBorderColor, width: 1)),
                        child: Text(                        
                                  state2.followings.following.any((element) => element.id==followers[index].id) 
                              ? 'Following'
                              : 'Followback',
                          style: const TextStyle(fontSize: 13),
                        ),
                      )),
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
