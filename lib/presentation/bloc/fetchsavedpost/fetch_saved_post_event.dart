part of 'fetch_saved_post_bloc.dart';

@immutable
sealed class FetchSavedPostEvent {}
final class FetchSavedpostInitialEvent extends FetchSavedPostEvent{}