part of 'connection_count_bloc.dart';

@immutable
sealed class ConnectionCountState {}

final class ConnectionCountInitial extends ConnectionCountState {}

final class ConnectionCountLoadingState extends ConnectionCountState {}

final class ConnectionCountSuccessState extends ConnectionCountState {
  final int followersCount;
  final int followingCount;

  ConnectionCountSuccessState({required this.followersCount, required this.followingCount});
}

final class ConnectionCountErrorState extends ConnectionCountState {}
