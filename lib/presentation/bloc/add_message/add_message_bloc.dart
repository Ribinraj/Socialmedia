import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'package:social_media_app/domain/repository/chat_repo.dart';

part 'add_message_event.dart';
part 'add_message_state.dart';

class AddMessageBloc extends Bloc<AddMessageEvent, AddMessageState> {
  AddMessageBloc() : super(AddMessageInitial()) {
    on<AddMessageEvent>((event, emit) {});
    on<AddMessageButtonClickEvent>(addmessageevent);
  }

  FutureOr<void> addmessageevent(
      AddMessageButtonClickEvent event, Emitter<AddMessageState> emit) async {
    emit(AddMessageLoadingState());
    final Response response = await ChatRopo.addmessage(
        recieverId: event.recieverId,
        text: event.message,
        conversationId: event.conversationId,
        senderId: event.senderId);
    debugPrint('addmessage:${response.statusCode}');
    if (response.statusCode == 200) {
      emit(AddMessageSuccessState());
    } else {
      emit(AddMessageErrorState());
    }
  }
}
