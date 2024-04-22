part of 'like_unlike_post_bloc.dart';

@immutable
sealed class LikeUnlikePostState {}

final class LikeUnlikePostInitial extends LikeUnlikePostState {}
final class LikedPostState extends LikeUnlikePostState{}
final class UnlikedPostState extends LikeUnlikePostState{}
final class InternalErrorState extends LikeUnlikePostState{}