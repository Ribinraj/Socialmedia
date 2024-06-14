import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/presentation/bloc/add_comment/add_comment_bloc.dart';
import 'package:social_media_app/presentation/bloc/add_message/add_message_bloc.dart';

import 'package:social_media_app/presentation/bloc/addpost/add_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/bloc/get_notification_bloc.dart';
import 'package:social_media_app/presentation/bloc/cmment_delete/comment_delete_bloc.dart';
import 'package:social_media_app/presentation/bloc/connection_count/connection_count_bloc.dart';
import 'package:social_media_app/presentation/bloc/conversation_bloc/conversation_bloc.dart';

import 'package:social_media_app/presentation/bloc/deletepost/delete_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/editbloc/edit_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/editprofile/edit_profile_bloc.dart';
import 'package:social_media_app/presentation/bloc/explore_post_bloc/explore_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetch_followers/fetch_followers_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetch_following.dart/fetch_followings_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchall_conversation/fetchall_conversation_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchcomment/fetch_comment_bloc.dart';

import 'package:social_media_app/presentation/bloc/fetchpost/fetch_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchsavedpost/fetch_saved_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/fetchuserpost/fetching_user_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/follow_unfollow/follow_unfollow_bloc.dart';
import 'package:social_media_app/presentation/bloc/followerspost/fetch_followerspost_bloc.dart';
import 'package:social_media_app/presentation/bloc/get_singleuser/get_singleuser_bloc.dart';
import 'package:social_media_app/presentation/bloc/imagepicker/image_picker_bloc.dart';
import 'package:social_media_app/presentation/bloc/like_unlikepost/like_unlike_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/login/login_bloc.dart';
import 'package:social_media_app/presentation/bloc/login_user/login_user_bloc.dart';

import 'package:social_media_app/presentation/bloc/otp/otp_bloc.dart';
import 'package:social_media_app/presentation/bloc/report_post/report_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/saved_post/saved_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/search_bloc/search_user_bloc.dart';
import 'package:social_media_app/presentation/bloc/signup/signup_bloc.dart';
import 'package:social_media_app/presentation/bloc/suggession_bloc/suggession_users_bloc.dart';
import 'package:social_media_app/presentation/cubit/cubits/cubit/toggle_password_cubit.dart';
import 'package:social_media_app/presentation/cubit/reportCubit/bottonav_cubit.dart';
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
          create: (context) => ReportCubit(),
        ),
        BlocProvider(
          create: (context) => AddPostBloc(),
        ),
        BlocProvider(
          create: (context) => FetchPostBloc(),
        ),
        BlocProvider(create: (context) => FetchingUserPostBloc()),
        BlocProvider(
          create: (context) => DeletePostBloc(),
        ),
        BlocProvider(
          create: (context) => EditPostBloc(),
        ),
        BlocProvider(
          create: (context) => LoginUserBloc(),
        ),
        BlocProvider(
          create: (context) => ImagePickerBloc(),
        ),
        BlocProvider(
          create: (context) => EditProfileBloc(),
        ),
        BlocProvider(
          create: (context) => FetchFollowerspostBloc(),
        ),
        BlocProvider(
          create: (context) => LikeUnlikePostBloc(),
        ),
        BlocProvider(
          create: (context) => FetchCommentBloc(),
        ),
        BlocProvider(
          create: (context) => AddCommentBloc(),
        ),
        BlocProvider(
          create: (context) =>CommentDeleteBloc()
        ),
        BlocProvider(
          create: (context) => SavedPostBloc(),
        ),
        BlocProvider(
          create: (context) => ReportPostBloc(),
        ),
        BlocProvider(
          create: (context) => FetchSavedPostBloc(),
        ),
        BlocProvider(
          create: (context) => SuggessionUsersBloc(),
        ),
          BlocProvider(
          create: (context) =>FollowUnfollowBloc(),
        ),
            BlocProvider(
          create: (context) =>FetchFollowingsBloc(),
        ),
             BlocProvider(
          create: (context) => FetchFollowersBloc(),
        ),
              BlocProvider(
          create: (context) => ExplorePostBloc(),
        ),
                 BlocProvider(
          create: (context) => SearchUserBloc(),
        ),
               BlocProvider(
          create: (context) => AddMessageBloc(),
        ) ,      BlocProvider(
          create: (context) => GetSingleuserBloc(),
        ),
               BlocProvider(
          create: (context) => FetchallConversationBloc(),
        ),
               BlocProvider(
          create: (context) =>ConversationBloc(),
        ),
                BlocProvider(
          create: (context) =>ConnectionCountBloc(),
        ),
                BlocProvider(
          create: (context) =>GetNotificationBloc(),
        ),
              BlocProvider(
          create: (context) =>TogglepasswordCubit(),
        )
      ],
      child: MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        title: 'Social_media',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'NetflixSans', primarySwatch: Colors.grey),
        home: const ScreenSplash(),
      ),
    );
  }
}
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

