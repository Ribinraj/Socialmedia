part of 'suggession_users_bloc.dart';

@immutable
sealed class SuggessionUsersState {}

final class SuggessionUsersInitial extends SuggessionUsersState {}

final class SuggessionUserLoadingState extends SuggessionUsersState {}

final class SuggessionUsersSuccessState extends SuggessionUsersState {
  final SuggessionUserModel suggessions;

  SuggessionUsersSuccessState({required this.suggessions});
}
final class SuggessionUsersInternalErrorState extends SuggessionUsersState{}