part of 'connection_count_bloc.dart';

@immutable
sealed class ConnectionCountEvent {}

final class ConnectionCountInitialEvent extends ConnectionCountEvent {
  final String userId;

  ConnectionCountInitialEvent({required this.userId});
}
