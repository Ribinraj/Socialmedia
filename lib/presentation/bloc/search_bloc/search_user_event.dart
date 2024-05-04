part of 'search_user_bloc.dart';

@immutable
sealed class SearchUserEvent {}

final class SearchUserInitialEvent extends SearchUserEvent {
  final String searchquery;

  SearchUserInitialEvent({required this.searchquery});
}
