
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/presentation/bloc/explore_post_bloc/explore_post_bloc.dart';
import 'package:social_media_app/presentation/screens/explorepost_screen/explorepost_screen.dart';
import 'package:social_media_app/presentation/screens/search_screen/widgets/debouncer.dart';
import 'package:social_media_app/presentation/screens/search_screen/widgets/search_idle.dart';
import 'package:social_media_app/presentation/screens/search_screen/widgets/shimmer_result.dart';
import 'package:social_media_app/presentation/widgets/custom_navigator.dart';

class SearchResultWidget extends StatefulWidget {
  const SearchResultWidget({super.key});

  @override
  State<SearchResultWidget> createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  @override
  void initState() {
    context.read<ExplorePostBloc>().add(FetchexplorepostInitialEvent());
    super.initState();
  }
   final Debouncer debouncer = Debouncer(milliseconds: 500);
  Future<void> fetchDataWithDebounceExplore() async {
    await debouncer.run(() async {
   context.read<ExplorePostBloc>().add(FetchexplorepostInitialEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh:fetchDataWithDebounceExplore ,
        child: SafeArea(
          child: BlocBuilder<ExplorePostBloc, ExplorePostState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      backgroundColor: Colors.white,
                      elevation: 0.5,
                      title: CupertinoSearchTextField(
                        backgroundColor: kpurpleMediumColor.withOpacity(0.4),
                        prefixIcon: const Icon(
                          CupertinoIcons.search,
                          color: kpurpleBorderColor,
                        ),
                        onTap: () {
                          navigatePush(context, const SearchIdle());
                        },
                        style: const TextStyle(color: kpurpleColor),
                      ),
                    ),
                    if (state is FetchExplorepostLoadingState)
                      const SliverFillRemaining(
                        child: ShimmerResultWidget(),
                      ),
                    if (state is FetchexplorepostSuccessState)
                      SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 3,
                          mainAxisSpacing: 3,
                          childAspectRatio: .75,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return InkWell(
                              onTap: () {
                                navigatePush(context,
                                    ScreenExplorePost(initialIndex: index));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: state.exploreposts[index].image,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child:
                                        LoadingAnimationWidget.fourRotatingDots(
                                            color: kpurpleMediumColor, size: 40),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            );
                          },
                          childCount: state.exploreposts.length,
                        ),
                      ),
                    if (state is! FetchexplorepostSuccessState &&
                        state is! FetchExplorepostLoadingState)
                      const SliverFillRemaining(
                        child: Center(
                          child: Text("No content available."),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
