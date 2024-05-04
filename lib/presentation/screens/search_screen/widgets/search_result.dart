import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:social_media_app/core/colors.dart';
import 'package:social_media_app/presentation/bloc/explore_post_bloc/explore_post_bloc.dart';
import 'package:social_media_app/presentation/screens/search_screen/widgets/shimmer_result.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ExplorePostBloc, ExplorePostState>(
          builder: (context, state) {
            if (state is FetchExplorepostLoadingState) {
              return const ShimmerResultWidget();
            } else if (state is FetchexplorepostSuccessState) {
              return CustomScrollView(
                slivers: [
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
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: state.exploreposts[index].image,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: LoadingAnimationWidget.fourRotatingDots(
                                  color: kpurpleMediumColor, size: 40),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        );
                      },
                      childCount: state.exploreposts.length,
                    ),
                  ),
                ],
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


// class MainCard extends StatelessWidget {
//   const MainCard({
//     super.key,
//   });
//   // final String poster;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       height: 100,
//       decoration: BoxDecoration(color: kpurpleBorderColor
//           // image:
//           //     DecorationImage(image: NetworkImage(poster), fit: BoxFit.cover),
//           // borderRadius: BorderRadius.circular(7)
//           ),
//     );
//   }
// }
