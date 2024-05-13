part of 'conversation_bloc.dart';

@immutable
sealed class ConversationEvent {}

final class CreateConversationButtonClickEvent extends ConversationEvent {
  final List<String> members;

  CreateConversationButtonClickEvent({required this.members});
}

final class FetchallMessageInitialEvent extends ConversationEvent {
  final String conversationId;

  FetchallMessageInitialEvent({required this.conversationId});
}

final class AddNewMessageEvent extends ConversationEvent {
  final AllMessagesModel message;

  AddNewMessageEvent({required this.message});
}
