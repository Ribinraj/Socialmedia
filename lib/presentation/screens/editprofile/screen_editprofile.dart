import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/data/models/loginuser_model.dart';
import 'package:social_media_app/presentation/bloc/imagepicker/image_picker_bloc.dart';
import 'package:social_media_app/presentation/widgets/custom_imagepicker.dart';
import 'package:social_media_app/presentation/widgets/custom_signin_button.dart';
import 'package:social_media_app/presentation/widgets/custom_textfield.dart';

class SreenProfileEdit extends StatefulWidget {
  final Loginuser loginuser;
  const SreenProfileEdit({super.key, required this.loginuser});

  @override
  State<SreenProfileEdit> createState() => _SreenProfileEditState();
}

class _SreenProfileEditState extends State<SreenProfileEdit> {
  XFile? imagepath;
  String image = '';

  late TextEditingController namecontroller;

  late TextEditingController biocontroller;
  @override
  void initState() {
    namecontroller = TextEditingController(text: widget.loginuser.name);

    biocontroller = TextEditingController(text: widget.loginuser.bio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double circleContainerSize = 130.0;
    final imagepickerbloc = context.read<ImagePickerBloc>();

    return Scaffold(
      backgroundColor: kpurplelightColor,
      body: BlocConsumer<ImagePickerBloc, ImagePickerState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ImagePickedState) {
            image = state.image;
          }
          return ListView(
            children: [
              Stack(
                children: [
                  const SizedBox(
                    height: 700,
                    width: double.infinity,
                  ),
                  Stack(children: [
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://img.freepik.com/free-photo/sports-car-driving-asphalt-road-night-generative-ai_188544-8052.jpg?w=900&t=st=1711111620~exp=1711112220~hmac=5dbcde759ef836ae9d03590c6b7500a636ee1b95c9fd83c2ff1c292472746715"),
                        ),
                      ),
                    ),
                    Positioned(
                        right: 50,
                        bottom: 60,
                        child: InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.edit_square,
                            color: kwhiteColor,
                          ),
                        ))
                  ]),
                  Positioned(
                    top: 200.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      height: 500,
                      decoration: BoxDecoration(
                        color: kpurplelightColor,
                        borderRadius: kradius30,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          CustomTextfield(
                              controller: namecontroller, labelText: 'Name'),
                          CustomTextfield(
                              controller: biocontroller, labelText: 'Bio'),
                          CustomSigninButton(
                              onPressed: () {}, buttonText: 'Update')
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: (size.width - circleContainerSize) / 2,
                    child: Stack(
                      children: [
                        Container(
                          height: circleContainerSize,
                          width: circleContainerSize,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: UnconstrainedBox(
                            child: ClipOval(
                              child: Container(
                                height: circleContainerSize - 10,
                                width: circleContainerSize - 10,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: image != ""
                                        ? Image.file(File(image)).image
                                        : NetworkImage(
                                            widget.loginuser.profilePic),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: InkWell(
                            onTap: () async {
                              imagepath = await showBottomSheetWidget(context);
                              if (imagepath != null) {
                                imagepickerbloc.add(AddImageEvent(
                                    image: image = imagepath!.path));
                              }
                            },
                            child: const Icon(
                              Icons.edit_square,
                              color: kblackColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
