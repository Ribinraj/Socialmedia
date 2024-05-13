part of 'conversation_bloc.dart';

@immutable
sealed class ConversationState {}

final class ConversationInitial extends ConversationState {}

final class ConversationLoadingState extends ConversationState {}

final class ConversationSuccessState extends ConversationState {
  final String convrsationId;

  ConversationSuccessState({required this.convrsationId});
}

final class ConversationErrorState extends ConversationState {}

//fetch allmessage
final class FetchAllmessageLoadingState extends ConversationState {}

final class FetchAllmessageSuccessfullState extends ConversationState {
  final List<AllMessagesModel> messageList;

  FetchAllmessageSuccessfullState({required this.messageList});
}
final class FetchAllmessageErrorState extends ConversationState{}
