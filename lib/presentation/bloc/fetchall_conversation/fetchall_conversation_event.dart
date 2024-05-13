part of 'fetchall_conversation_bloc.dart';

@immutable
sealed class FetchallConversationEvent {}

final class AllConversationsInitialFetchEvent
    extends FetchallConversationEvent {}

final class SearchconversationEvent extends FetchallConversationEvent {
  final String query;

  SearchconversationEvent({required this.query});
}
