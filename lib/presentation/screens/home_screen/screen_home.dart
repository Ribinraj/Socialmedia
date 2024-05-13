import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/data/socket/socket.dart';

import 'package:social_media_app/presentation/bloc/followerspost/fetch_followerspost_bloc.dart';
import 'package:social_media_app/presentation/bloc/like_unlikepost/like_unlike_post_bloc.dart';

import 'package:social_media_app/presentation/bloc/saved_post/saved_post_bloc.dart';
import 'package:social_media_app/presentation/bloc/suggession_bloc/suggession_users_bloc.dart';

import 'package:social_media_app/presentation/screens/home_screen/widgets/appbar_section.dart';

import 'package:social_media_app/presentation/screens/home_screen/widgets/post_section.dart';

import 'package:social_media_app/presentation/screens/home_screen/widgets/shimmer_homepage.dart';

import 'package:social_media_app/core/colors.dart';

import 'package:social_media_app/presentation/screens/home_screen/widgets/suggession_section.dart';

import 'package:social_media_app/presentation/screens/search_screen/widgets/debouncer.dart';

import 'package:social_media_app/presentation/widgets/custom_snakbar.dart';

import 'package:social_media_app/presentation/widgets/shared_preferences.dart';
import 'package:social_media_app/presentation/widgets/tex.dart';

String loginuserid = '';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int currentPage = 1;
  void _loadMore() {
    context.read<FetchFollowerspostBloc>().add(LoadMoreFollowersPostsEvent());
  }

  @override
  void initState() {
    context
        .read<FetchFollowerspostBloc>()
        .add(InitialFetchingEventFollowersPost(n: currentPage));
    context.read<SuggessionUsersBloc>().add(SuggessionUsersInitialEvent());
    getloginuserId();
    SocketService().connectSocket();
    super.initState();
  }

  getloginuserId() async {
    loginuserid = (await getUserId())!;
  }

  final Debouncer debouncer = Debouncer(milliseconds: 500);

  Future<void> fetchDataWithDebounce() async {
    await debouncer.run(() async {
      context
          .read<FetchFollowerspostBloc>()
          .add(InitialFetchingEventFollowersPost(n: currentPage));
      context.read<SuggessionUsersBloc>().add(SuggessionUsersInitialEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final likebloc = context.read<LikeUnlikePostBloc>();
    final savedbloc = context.read<SavedPostBloc>();

    Size size = MediaQuery.of(context).size;
    const double circleContainerSize = 70;
    return SafeArea(
      
      child: Scaffold(
        body: BlocConsumer<FetchFollowerspostBloc, FetchFollowerspostState>(
          listener: (context, state) {
            if (state is FetchFollowersPostInternalErrorstate) {
              return customSnackbar(
                  context, 'internal Server Error', kredcolor);
            }
          },
          builder: (context, state) {
            if (state is FetchFollowersPostLoadingState) {
              return const Screenhomeshimmer();
            } else if (state is FetchFollowersPostSuccessState) {
              return NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, bool isScrolled) {
                  return [const AppbarSection()];
                },
                body: RefreshIndicator(
                  onRefresh: fetchDataWithDebounce,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: customHeadingtext('Suggestions', 17,
                              fontWeight: FontWeight.w500,
                              textColor: kpurpleColor),
                        ),
                        LimitedBox(
                          maxHeight: 110,
                          child: BlocBuilder<SuggessionUsersBloc,
                              SuggessionUsersState>(
                            builder: (context, state3) {
                              if (state3 is SuggessionUsersSuccessState) {
                                return SuggessionPart(
                                    state3: state3,
                                    circleContainerSize: circleContainerSize);
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ),
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: state.followersposts.length + 1,
                          itemBuilder: (context, index) {
                            if (index == state.followersposts.length) {
                              return Visibility(
                                visible: state.followersposts.length % 5 == 0,
                                child: TextButton(
                                  onPressed: _loadMore,
                                  child: const Text('Load More'),
                                ),
                              );
                            } else {
                              return PostSection(
                                  index: index,
                                  state: state,
                                  savedbloc: savedbloc,
                                  size: size,
                                  likebloc: likebloc);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
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
