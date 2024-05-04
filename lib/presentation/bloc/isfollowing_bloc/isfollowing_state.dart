part of 'isfollowing_bloc.dart';

@immutable
sealed class IsfollowingState {}

final class IsfollowingInitial extends IsfollowingState {}
final class IsfollowingSuccessState extends IsfollowingState  {
  final bool isfollowing;

  IsfollowingSuccessState({required this.isfollowing});
}

final class IsfollowInternalErrorState extends IsfollowingState  {}