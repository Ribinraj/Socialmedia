part of 'fetch_followings_bloc.dart';

@immutable
sealed class FetchFollowingsEvent {}
final class FetchFollowingInitialEvent extends FetchFollowingsEvent{}