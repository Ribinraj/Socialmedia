import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'package:social_media_app/data/models/get_conversation.dart';
import 'package:social_media_app/data/models/get_singleuser_model.dart';
import 'package:social_media_app/domain/repository/chat_repo.dart';
import 'package:social_media_app/domain/repository/user_repo.dart';

import 'package:social_media_app/presentation/widgets/shared_preferences.dart';

part 'fetchall_conversation_event.dart';
part 'fetchall_conversation_state.dart';

class FetchallConversationBloc
    extends Bloc<FetchallConversationEvent, FetchallConversationState> {
  FetchallConversationBloc() : super(FetchallConversationInitial()) {
    on<FetchallConversationEvent>((event, emit) {});
    on<AllConversationsInitialFetchEvent>(allconversationinitialfetchevent);
  }

  FutureOr<void> allconversationinitialfetchevent(
      AllConversationsInitialFetchEvent event,
      Emitter<FetchallConversationState> emit) async {
    emit(FetchAllCnversationLoadingstate());
    final userid = await getUserId();
    final Response response = await ChatRopo.getconversation();
    debugPrint('fetchconversation statuscode:${response.statusCode}');
    debugPrint('fetchallconversationbody:${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responsedata = jsonDecode(response.body);
      final List<dynamic> conversationdata = responsedata['data'];
      final List<ConversationModel> conversations = conversationdata
          .map((conversationJson) =>
              ConversationModel.fromJson(conversationJson))
          .toList();
      final List<String> otheruserIds = conversations
          .expand((conversation) => conversation.members)
          .where((userId) => userId != userid)
          .toList();
      List<GetUserModel> otherusers = [];
      for (String userId in otheruserIds) {
        final Response userResponse =
            await LoginUserRepo.getsingleuser(userId: userId);
        if (userResponse.statusCode == 200) {
          final Map<String, dynamic> userJson = jsonDecode(userResponse.body);
          final GetUserModel user = GetUserModel.fromJson(userJson);
          otherusers.add(user);
        }
      }
      if (otherusers.length == otheruserIds.length) {
        emit(FetchAllconversationSuccessState(
            conversations: conversations, otherusers: otherusers));
      } else {
        emit(FetchAllconversatonErrorState());
      }
      }else{
        emit(FetchAllconversatonErrorState());
      }
    }
  }

