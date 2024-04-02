import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/deletepost/delete_post_bloc.dart';

import 'package:social_media_app/presentation/bloc/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:social_media_app/presentation/screens/editpost/sreen_editpost.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';
import 'package:social_media_app/presentation/widgets/custom_round_image.dart';
import 'package:social_media_app/presentation/widgets/custom_snakbar.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

class SreenUserPost extends StatefulWidget {
  const SreenUserPost({super.key});

  @override
  State<SreenUserPost> createState() => _SreenUserPostState();
}

class _SreenUserPostState extends State<SreenUserPost> {
  @override
  void initState() {
    context.read<FetchingUserPostBloc>().add(FetchingUserpostInitialEvent());
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
            context
                .read<FetchingUserPostBloc>()
                .add(FetchingUserpostInitialEvent());
            customSnackbar(context, 'deleted Successfully', kgreencolor);
          } else if (state is DeletePostInternalServerErrorState) {
            customSnackbar(context, 'internal server error', kredcolor);
          }
        },
        child: BlocConsumer<FetchingUserPostBloc, FetchingUserPostState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FetchUserPostLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kpurpleBorderColor,
                ),
              );
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
                      height: 550,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: kpurpledoublelightColor,
                          borderRadius: kradius10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CustomRoundImage(
                                  circleContainerSize: 45,
                                  imageUrl:
                                      "https://i.pinimg.com/736x/d0/4b/1f/d04b1f2ed3ca8ad4a302fbe9f4f5a875.jpg"),
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
                              PopupMenuButton(
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry>[
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ],
                                onSelected: (value) {
                                  // Handle the selected option here
                                  if (value == 'edit') {
                                    navigatePush(
                                        context,  ScreenEditPost(userpost: state.userposts[index],));
                                  } else if (value == 'delete') {
                                    deletoepostBloc.add(DeletepostClickEvent(
                                        postid: state.userposts[index].id));
                                  }
                                },
                                icon: const Icon(Icons.more_vert),
                              ),
                            ],
                          ),
                          kheight,
                          Container(
                            width: size.width,
                            height: 370,
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
