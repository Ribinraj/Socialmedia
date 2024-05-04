import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:social_media_app/data/models/suggessionuser_model.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';

part 'suggession_users_event.dart';
part 'suggession_users_state.dart';

class SuggessionUsersBloc
    extends Bloc<SuggessionUsersEvent, SuggessionUsersState> {
  SuggessionUsersBloc() : super(SuggessionUsersInitial()) {
    on<SuggessionUsersEvent>((event, emit) {});
    on<SuggessionUsersInitialEvent>(suggessionuserevent);
  }

  FutureOr<void> suggessionuserevent(SuggessionUsersInitialEvent event,
      Emitter<SuggessionUsersState> emit) async {
    emit(SuggessionUserLoadingState());
    final Response response = await PostRepo.fetchsuggestion();

    if (response.statusCode == 200) {
      final Map<String, dynamic> responsedata = jsonDecode(response.body);
      SuggessionUserModel suggession =
          SuggessionUserModel.fromJson(responsedata);

      emit(SuggessionUsersSuccessState(suggessions: suggession));
    } else if (response.statusCode == 500) {
      emit(SuggessionUsersInternalErrorState());
    }
  }
}
