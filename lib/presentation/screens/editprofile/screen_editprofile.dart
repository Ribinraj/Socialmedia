// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:social_media_app/core/colors.dart';
// import 'package:social_media_app/core/constants.dart';
// import 'package:social_media_app/data/models/loginuser_model.dart';
// import 'package:social_media_app/presentation/bloc/editprofile/edit_profile_bloc.dart';
// import 'package:social_media_app/presentation/bloc/imagepicker/image_picker_bloc.dart';
// import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';
// import 'package:social_media_app/presentation/widgets/custom_imagepicker.dart';
// import 'package:social_media_app/presentation/widgets/custom_signin_button.dart';
// import 'package:social_media_app/presentation/widgets/custom_snakbar.dart';
// import 'package:social_media_app/presentation/widgets/custom_textfield.dart';
// import 'package:multi_bloc_builder/multi_bloc_builder.dart';

// class SreenProfileEdit extends StatefulWidget {
//   final Loginuser loginuser;
//   const SreenProfileEdit({super.key, required this.loginuser});

//   @override
//   State<SreenProfileEdit> createState() => _SreenProfileEditState();
// }

// class _SreenProfileEditState extends State<SreenProfileEdit> {
//   XFile? imagepath;
//   File? image;

//   late TextEditingController namecontroller;

//   late TextEditingController biocontroller;
//   @override
//   void initState() {
//     namecontroller = TextEditingController(text: widget.loginuser.name);

//     biocontroller = TextEditingController(text: widget.loginuser.bio);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     const double circleContainerSize = 130.0;
//     final imagepickerbloc = context.read<ImagePickerBloc>();
//     final editProfilebloc = context.read<EditProfileBloc>();

//     return Scaffold(
//       backgroundColor: kpurplelightColor,
//       body: MultiBlocConsumer(
//         buildWhen: (p0, p1) {
//           return true;
//         },
//         listener: (context, state) {
//             // var state1 = state[0];
//             var state2 = state[1];
//           if (state2 is EditProfileSuccessState) {

//             context.read<LoginUserBloc>().add(LoginUserInitialFetchingEvent());
//             customSnackbar(context, 'profile edited Successfull', kgreencolor);
//             Navigator.pop(context);
//           }
//         },
//         blocs: [
//           context.watch<ImagePickerBloc>(),
//           context.watch<EditProfileBloc>()
//         ],
//         builder: (context, state) {
//           var state1 = state[0];
//           // var state2 = state[1];
//           if (state1 is ImagePickedState) {
//             image = state1.image;
//           }
//           return ListView(
//             children: [
//               Stack(
//                 children: [
//                   const SizedBox(
//                     height: 700,
//                     width: double.infinity,
//                   ),
//                   Stack(children: [
//                     Container(
//                       width: double.infinity,
//                       height: 250,
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: NetworkImage(
//                               "https://img.freepik.com/free-photo/sports-car-driving-asphalt-road-night-generative-ai_188544-8052.jpg?w=900&t=st=1711111620~exp=1711112220~hmac=5dbcde759ef836ae9d03590c6b7500a636ee1b95c9fd83c2ff1c292472746715"),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                         right: 50,
//                         bottom: 60,
//                         child: InkWell(
//                           onTap: () {},
//                           child: const Icon(
//                             Icons.edit_square,
//                             color: kwhiteColor,
//                           ),
//                         ))
//                   ]),
//                   Positioned(
//                     top: 200.0,
//                     left: 0.0,
//                     right: 0.0,
//                     child: Container(
//                       height: 500,
//                       decoration: BoxDecoration(
//                         color: kpurplelightColor,
//                         borderRadius: kradius30,
//                       ),
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 100,
//                           ),
//                           CustomTextfield(
//                               controller: namecontroller, labelText: 'Name'),
//                           CustomTextfield(
//                               controller: biocontroller, labelText: 'Bio'),
//                           CustomSigninButton(
//                               onPressed: () {
//                                 debugPrint('file:$image.toString()');
//                                 editProfilebloc.add(EditprofileClickEvent(
//                                     name: namecontroller.text,
//                                     bio: biocontroller.text,
//                                     image: image,
//                                     imageurl: widget.loginuser.profilePic));
//                               },
//                               buttonText: 'Update')
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 140,
//                     left: (size.width - circleContainerSize) / 2,
//                     child: Stack(
//                       children: [
//                         Container(
//                           height: circleContainerSize,
//                           width: circleContainerSize,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.white,
//                           ),
//                           child: UnconstrainedBox(
//                             child: ClipOval(
//                               child: Container(
//                                 height: circleContainerSize - 10,
//                                 width: circleContainerSize - 10,
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image: image != null
//                                         ? Image.file(image!).image
//                                         : NetworkImage(
//                                             widget.loginuser.profilePic),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 10,
//                           right: 10,
//                           child: InkWell(
//                             onTap: () async {
//                               imagepath = await showBottomSheetWidget(context);
//                               if (imagepath != null) {
//                                 imagepickerbloc.add(AddImageEvent(
//                                     image: image = File(imagepath!.path)));
//                               }
//                             },
//                             child: const Icon(
//                               Icons.edit_square,
//                               color: kblackColor,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
/////////
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/core/constants.dart';
import 'package:social_media_app/data/models/loginuser_model.dart';
import 'package:social_media_app/presentation/bloc/editprofile/edit_profile_bloc.dart';
import 'package:social_media_app/presentation/bloc/imagepicker/image_picker_bloc.dart';
import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';

import 'package:social_media_app/presentation/widgets/custom_imagepicker.dart';
import 'package:social_media_app/presentation/widgets/custom_signin_button.dart';
import 'package:social_media_app/presentation/widgets/custom_snakbar.dart';

import 'package:social_media_app/presentation/widgets/custom_textfield.dart';

class SreenProfileEdit extends StatefulWidget {
  final Loginuser loginuser;
  const SreenProfileEdit({super.key, required this.loginuser});

  @override
  State<SreenProfileEdit> createState() => _SreenProfileEditState();
}

class _SreenProfileEditState extends State<SreenProfileEdit> {
  XFile? imagepath;
  File? image;
  File? backgroundimage;

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
    final editProfilebloc = context.read<EditProfileBloc>();

    return Scaffold(
      backgroundColor: kpurplelightColor,
      body: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state1) {
          if (state1 is EditProfileSuccessState) {
            context.read<LoginUserBloc>().add(LoginUserInitialFetchingEvent());
            customSnackbar(context, 'profile edited Successfull', kgreencolor);
            Navigator.pop(context);
          }
        },
        builder: (context, state1) {
          if (state1 is EditProfileLoadingState) {
            return Center(child: LoadingAnimationWidget.fourRotatingDots(color: kpurpleMediumColor, size:40 ),);
          }
          return BlocConsumer<ImagePickerBloc, ImagePickerState>(
            listener: (context, state) {
              if (state is ImagePickedState) {
                image = state.image;
              }
              if (state is BackgroundImagePickedstate) {
                backgroundimage = state.backgroundimage;
              }
            },
            builder: (context, state) {
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
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: backgroundimage != null
                                  ? Image.file(backgroundimage!).image
                                  : NetworkImage(
                                      widget.loginuser.backGroundImage),
                            ),
                          ),
                        ),
                        Positioned(
                            right: 50,
                            bottom: 60,
                            child: InkWell(
                              onTap: () async {
                                imagepath =
                                    await showBottomSheetWidget(context);
                                if (imagepath != null) {
                                  imagepickerbloc.add(
                                      AddBackgroundImageAddEvent(
                                          backgroundimage: backgroundimage =
                                              File(imagepath!.path)));
                                }
                              },
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
                                  controller: namecontroller,
                                  labelText: 'Name'),
                              CustomTextfield(
                                  controller: biocontroller, labelText: 'Bio'),
                              CustomSigninButton(
                                  onPressed: () {
                                    debugPrint('file:$image.toString()');
                                    editProfilebloc.add(EditprofileClickEvent(
                                        name: namecontroller.text,
                                        bio: biocontroller.text,
                                        image: image,
                                        backgroundImage: backgroundimage,
                                        backgroundImageurl:
                                            widget.loginuser.backGroundImage,
                                        imageurl: widget.loginuser.profilePic));
                                  },
                                  buttonText: 'Update')
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
                                        image: image != null
                                            ? Image.file(image!).image
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
                                  imagepath =
                                      await showBottomSheetWidget(context);
                                  if (imagepath != null) {
                                    imagepickerbloc.add(AddImageEvent(
                                        image: image = File(imagepath!.path)));
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
          );
        },
      ),
    );
  }
}
