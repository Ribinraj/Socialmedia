part of 'get_singleuser_bloc.dart';

@immutable
sealed class GetSingleuserState {}

final class GetSingleuserInitial extends GetSingleuserState {}

final class GetSingleuserLoadingState extends GetSingleuserState {}

final class GetSingleuserSuccessState extends GetSingleuserState {
  final GetUserModel user;

  GetSingleuserSuccessState({required this.user});
}
final class GetSingleUserErrorState extends GetSingleuserState{}