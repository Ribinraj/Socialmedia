import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:social_media_app/data/models/getall_messagemodel.dart';
import 'package:social_media_app/domain/repository/chat_repo.dart';

part 'conversation_event.dart';
part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  List<AllMessagesModel> messagesList = [];
  ConversationBloc() : super(ConversationInitial()) {
    on<ConversationEvent>((event, emit) {});
    on<CreateConversationButtonClickEvent>(createconversationevent);
    on<FetchallMessageInitialEvent>(fetchallmessageinitialevent);
    on<AddNewMessageEvent>(addnewmessageevent);
  }

  FutureOr<void> createconversationevent(
      CreateConversationButtonClickEvent event,
      Emitter<ConversationState> emit) async {
    emit(ConversationLoadingState());
    final Response response =
        await ChatRopo.createconversation(members: event.members);
    debugPrint('create conversationstauscode:${response.statusCode}');
    debugPrint('create conversationsresponse:${response.body}');
    final Map<String, dynamic> responsedata = jsonDecode(response.body);
    final String conversationId = responsedata['data']['_id'];
    debugPrint('create conversationsresponse:$responsedata');
    if (response.statusCode == 200) {
      emit(ConversationSuccessState(convrsationId: conversationId));
    } else {
      emit(ConversationErrorState());
    }
  }

  FutureOr<void> fetchallmessageinitialevent(FetchallMessageInitialEvent event,
      Emitter<ConversationState> emit) async {
    emit(FetchAllmessageLoadingState());
    final Response response =
        await ChatRopo.getallmessages(conversationId: event.conversationId);
    debugPrint('getallmessagestauscode:${response.statusCode}');
    if (response.statusCode == 200) {
      final jsonresponse = jsonDecode(response.body);
      final List<dynamic> datalist = jsonresponse['data'];
      messagesList =
          datalist.map((json) => AllMessagesModel.fromJson(json)).toList();
      messagesList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      emit(FetchAllmessageSuccessfullState(messageList: messagesList));
    } else {
      emit(FetchAllmessageErrorState());
    }
  }

  FutureOr<void> addnewmessageevent(
      AddNewMessageEvent event, Emitter<ConversationState> emit) async {
    messagesList.add(event.message);
    messagesList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    emit(FetchAllmessageSuccessfullState(messageList: messagesList));
  }
}
