import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/presentation/bloc/addpost/add_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchpost/fetch_post_bloc.dart';
import 'package:social_media_app/presentation/screens/add_post/widgets/mediaPicker.dart';
import 'package:social_media_app/presentation/screens/add_post/widgets/pageview.dart';
import 'package:social_media_app/presentation/screens/add_post/widgets/post_textfield.dart';
import 'package:social_media_app/presentation/screens/main_page/screen_main_page.dart';

import 'package:social_media_app/presentation/widgets/custom_signin_button.dart';
import 'package:social_media_app/presentation/widgets/custom_snakbar.dart';

import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenAddPost extends StatefulWidget {
  const ScreenAddPost({Key? key}) : super(key: key);

  @override
  State<ScreenAddPost> createState() => _ScreenAddPostState();
}

class _ScreenAddPostState extends State<ScreenAddPost> {
  final descriptioncontroller = TextEditingController();
  List<AssetEntity> selectedAssetList = [];

  Future pickAssets(
      {required int maxCount, required RequestType requestType}) async {
    final result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MediaPicker(maxCount: maxCount, requestType: requestType);
    }));
    if (result != null && (result as List).isNotEmpty) {
      setState(() {
        selectedAssetList = result as List<AssetEntity>;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final addpostbloc = context.read<AddPostBloc>();
    return Scaffold(
      backgroundColor: kpurpleColor,
      appBar: AppBar(
        title: customHeadingtext('Add Post', 20),
        centerTitle: true,
        backgroundColor: kpurpleColor,
      ),
      body: BlocConsumer<AddPostBloc, AddPostState>(
        listener: (context, state) {
          if (state is AddPostSuccessState) {
            context.read<FetchPostBloc>().add(FetchPostInitialEvent());
            customSnackbar(context, 'post Added Successfully', kgreencolor);
          } else if (state is AddPostErrorStateDatabaseError) {
            customSnackbar(context, 'Database Error', kredcolor);
          } else if (state is AddPostErrorStateInternalServerError) {
            customSnackbar(context, 'Internal server error', kredcolor);
          }
          currentPage.value = 0;
        },
        builder: (context, state) {
          if (state is AddPostLoadingstate) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: kpurplelightColor,
              child: Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: kpurpleMediumColor, size: 40),
              ),
            );
          }
          return Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
              color: kwhiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: 600,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: kradius20,
                      color: kpurpledoublelightColor,
                      border: Border.all(width: 2, color: kpurpleBorderColor),
                    ),
                    child: Column(
                      children: [
                        kheight30,
                        Expanded(
                          child: PageviewInAddpost(
                              selectedAssetList: selectedAssetList),
                        ),
                        PostTextfield(
                          controller: descriptioncontroller,
                          labelText: 'Type here!',
                        ),
                        Container(
                          width: size.width,
                          height: 50,
                          color: kpurplelightColor,
                          child: Row(
                            children: [
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    pickAssets(
                                        maxCount: 10,
                                        requestType: RequestType.common);
                                  },
                                  icon: const Icon(
                                    Icons.image,
                                    color: kpurpleColor,
                                    size: 38,
                                  )),
                              SizedBox(
                                height: 50,
                                width: 220,
                                child: CustomSigninButton(
                                    onPressed: () {
                                      addpostbloc.add(
                                        AddPostClickEvent(
                                            image: selectedAssetList[0],
                                            description:
                                                descriptioncontroller.text),
                                      );
                                      descriptioncontroller.clear();
                                      selectedAssetList.clear();
                                    },
                                    buttonText: 'Add Post'),
                              )
                            ],
                          ),
                        ),
                        kheight30
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
