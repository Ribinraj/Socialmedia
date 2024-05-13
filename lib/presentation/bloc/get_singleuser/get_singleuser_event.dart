part of 'get_singleuser_bloc.dart';

@immutable
sealed class GetSingleuserEvent {}

final class GetSingleUserInitialFetchEvent extends GetSingleuserEvent {
  final String userId;

  GetSingleUserInitialFetchEvent({required this.userId});
}
