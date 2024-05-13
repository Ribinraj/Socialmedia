part of 'fetchall_conversation_bloc.dart';

@immutable
sealed class FetchallConversationState {}

final class FetchallConversationInitial extends FetchallConversationState {}

final class FetchAllCnversationLoadingstate extends FetchallConversationState {}

final class FetchAllconversationSuccessState extends FetchallConversationState {
  final List<ConversationModel> conversations;
  final List<GetUserModel> otherusers;

  FetchAllconversationSuccessState({required this.conversations, required this.otherusers});
}
final class FetchAllconversatonErrorState extends FetchallConversationState{}