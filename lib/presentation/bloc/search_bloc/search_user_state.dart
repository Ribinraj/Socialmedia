part of 'search_user_bloc.dart';

@immutable
sealed class SearchUserState {}

final class SearchUserInitial extends SearchUserState {}

final class SearchUserLoadingState extends SearchUserState {}

final class SearchUserSuccessState extends SearchUserState {
  final List<SearcUserModel> searchuser;

  SearchUserSuccessState({required this.searchuser});
}

final class SearchUserInternalErrorState extends SearchUserState {}
