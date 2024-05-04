part of 'explore_post_bloc.dart';

@immutable
sealed class ExplorePostState {}

final class ExplorePostInitial extends ExplorePostState {}

final class FetchExplorepostLoadingState extends ExplorePostState {}

final class FetchexplorepostSuccessState extends ExplorePostState {
  final List<ExplorepostModel> exploreposts;

  FetchexplorepostSuccessState({required this.exploreposts});

 
}
final class FetchSavedpostInternalErrorState extends ExplorePostState{}