import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/deletepost/delete_post_bloc.dart';

import 'package:social_media_app/presentation/bloc/fetchuserpost/fetching_user_post_bloc.dart';

import 'package:social_media_app/presentation/screens/user_post/widgets/popupmenu_button.dart';

import 'package:social_media_app/presentation/widgets/custom_round_image.dart';
import 'package:social_media_app/presentation/widgets/custom_snakbar.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class SreenUserPost extends StatefulWidget {
  final String userId;
  const SreenUserPost({super.key, required this.userId});

  @override
  State<SreenUserPost> createState() => _SreenUserPostState();
}

class _SreenUserPostState extends State<SreenUserPost> {
  @override
  void initState() {
    context.read<FetchingUserPostBloc>().add(FetchingUserpostInitialEvent(userId: widget.userId));
    // context.read<FetchPostBloc>().add(FetchPostInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final deletoepostBloc = context.read<DeletePostBloc>();
    return Scaffold(
      appBar: AppBar(
        title: customHeadingtext('Posts', 25,
            textColor: kpurpleColor, fontWeight: FontWeight.w500),
        backgroundColor: kpurpledoublelightColor,
        centerTitle: true,
      ),
      body: BlocListener<DeletePostBloc, DeletePostState>(
        listener: (context, state) {
          if (state is DeletePostSuccessState) {
            // context.read<FetchPostBloc>().add(FetchPostInitialEvent());
            context
                .read<FetchingUserPostBloc>()
                .add(FetchingUserpostInitialEvent(userId: widget.userId));
            customSnackbar(context, 'deleted Successfully', kgreencolor);
          } else if (state is DeletePostInternalServerErrorState) {
            customSnackbar(context, 'internal server error', kredcolor);
          }
        },
        child: BlocConsumer<FetchingUserPostBloc, FetchingUserPostState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FetchUserPostLoadingState) {
              return Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                      color: kpurpleMediumColor, size: 40));
            } else if (state is FetchUserPostSuccessState) {
              return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: state.userposts.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 5,
                        right: 5,
                      ),
                      height: 520,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: kpurpledoublelightColor,
                          borderRadius: kradius10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomRoundImage(
                                  circleContainerSize: 45,
                                  imageUrl:
                                      state.userposts[index].userId.profilePic),
                              kwidth,
                              Column(
                                children: [
                                  customHeadingtext(
                                      state.userposts[index].userId.userName,
                                      18,
                                      textColor: kblackColor,
                                      fontWeight: FontWeight.bold),
                                  customstyletext('11 hours ago', 15,
                                      textColor: kgreycolor)
                                ],
                              ),
                              const Spacer(),
                              PopupmenuButton(
                                  deletoepostBloc: deletoepostBloc,
                                  state: state,
                                  index: index)
                            ],
                          ),
                          kheight,
                          Container(
                            width: size.width,
                            height: 340,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      state.userposts[index].image),
                                ),
                                borderRadius: kradius10),
                          ),
                          kheight,
                          SizedBox(
                            height: 50,
                            child: customHeadingtext(
                              state.userposts[index].description,
                              16,
                              textColor: kblackColor,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: kredcolor,
                                  )),
                              customHeadingtext(
                                  '${state.userposts[index].likes.length}', 15,
                                  textColor: kblackColor),
                              kwidth,
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.comment)),
                            ],
                          )
                        ],
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
      ),
    );
  }
}
