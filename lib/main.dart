import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/presentation/bloc/addpost/add_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/deletepost/delete_post_bloc.dart';

import 'package:social_media_app/presentation/bloc/fetchpost/fetch_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/login/login_bloc.dart';
import 'package:social_media_app/presentation/bloc/otp/otp_bloc.dart';
import 'package:social_media_app/presentation/bloc/signup/signup_bloc.dart';
import 'package:social_media_app/presentation/cubit/bottomnav_cubit/bottonav_cubit.dart';

import 'package:social_media_app/presentation/screens/splash_screen/screen_splash.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupBloc(),
        ),
        BlocProvider(
          create: (context) => OtpBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => BottomnavCubit(),
        ),
          BlocProvider(
          create: (context) =>AddPostBloc(),
        ),
           BlocProvider(
          create: (context) =>FetchPostBloc(),
        ),BlocProvider(create: (context)=>FetchingUserPostBloc()),
        BlocProvider(
          create: (context) => DeletePostBloc(),
          child: Container(),
        )
      ],
      child: MaterialApp(
        title: 'Social_media',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'NetflixSans', primarySwatch: Colors.grey),
        home: const ScreenSplash(),
      ),
    );
  }
}