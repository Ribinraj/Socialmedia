import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/data/models/post_model.dart';

import 'package:social_media_app/presentation/bloc/editbloc/edit_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:social_media_app/presentation/screens/add_post/widgets/mediaPicker.dart';
import 'package:social_media_app/presentation/screens/add_post/widgets/post_textfield.dart';
import 'package:social_media_app/presentation/widgets/cloudinary.dart';

import 'package:social_media_app/presentation/widgets/custom_signin_button.dart';
import 'package:social_media_app/presentation/widgets/custom_snakbar.dart';

import 'package:social_media_app/presentation/widgets/tex.dart';

class ScreenEditPost extends StatefulWidget {
  final Postmodel userpost;
  const ScreenEditPost({Key? key, required this.userpost}) : super(key: key);

  @override
  State<ScreenEditPost> createState() => _ScreenAddPostState();
}

class _ScreenAddPostState extends State<ScreenEditPost> {
  late TextEditingController descriptioncontroller;
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
  void initState() {
    descriptioncontroller =
        TextEditingController(text: widget.userpost.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final editpostbloc = context.read<EditPostBloc>();
    return Scaffold(
      backgroundColor: kpurpleColor,
      appBar: AppBar(
        title: customHeadingtext('Edit Post', 20),
        centerTitle: true,
        backgroundColor: kpurpleColor,
      ),
      body: BlocListener<EditPostBloc, EditPostState>(
        listener: (context, state) {
          if (state is EditPostSuccessState) {
            customSnackbar(context, 'Edited Successfully', kgreencolor);
            Navigator.pop(context);
            context
                .read<FetchingUserPostBloc>()
                .add(FetchingUserpostInitialEvent());
          } else if (state is EditpostErrorStateInternalServerError) {
            customSnackbar(context, 'Internal Server Error', kredcolor);
          }
        },
        child: Container(
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
                        child: PageView.builder(
                          itemCount: selectedAssetList.isNotEmpty
                              ? selectedAssetList.length
                              : 1,
                          itemBuilder: (context, index) {
                            if (selectedAssetList.isNotEmpty) {
                              final assetEntity = selectedAssetList[index];
                              return Stack(
                                children: [
                                  Positioned.fill(
                                    child: AssetEntityImage(
                                      assetEntity,
                                      isOriginal: false,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(
                                            Icons.error,
                                            color: kredcolor,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  if (assetEntity.type == AssetType.video)
                                    const Positioned(
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Icon(
                                            Icons.image,
                                            color: kredcolor,
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              );
                            } else {
                              return Image.network(
                                widget.userpost.image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.error,
                                      color: kredcolor,
                                    ),
                                  );
                                },
                              );
                            }
                          },
                        ),
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
                                  onPressed: () async {
                                    final String image =
                                        selectedAssetList.isNotEmpty
                                            ? await uploadImage(
                                                selectedAssetList[0])
                                            : widget.userpost.image;

                                    editpostbloc.add(EditPostClickevent(
                                        imageurl: image,
                                        description: descriptioncontroller.text,
                                        postid: widget.userpost.id));
                                  },
                                  buttonText: 'Edit Post'),
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
        ),
      ),
    );
  }
}
