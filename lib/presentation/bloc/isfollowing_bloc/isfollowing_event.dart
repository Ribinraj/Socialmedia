part of 'isfollowing_bloc.dart';

@immutable
sealed class IsfollowingEvent {}
final class IsfollowingInitialEvent extends IsfollowingEvent {
  final String userId;

  IsfollowingInitialEvent({required this.userId});
}
