import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'package:social_media_app/data/models/savedpost_model.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';

part 'fetch_saved_post_event.dart';
part 'fetch_saved_post_state.dart';

class FetchSavedPostBloc
    extends Bloc<FetchSavedPostEvent, FetchSavedPostState> {
  FetchSavedPostBloc() : super(FetchSavedPostInitial()) {
    on<FetchSavedPostEvent>((event, emit) {});
    on<FetchSavedpostInitialEvent>(fetchsavedpostevent);
  }

  FutureOr<void> fetchsavedpostevent(FetchSavedpostInitialEvent event,
      Emitter<FetchSavedPostState> emit) async {
    emit(FetchSavedpostLoadingState());
    final Response response = await PostRepo.fetchsavedpost();
   
    if (response.statusCode == 200) {
       List<SavedpostModel> savedPosts = (jsonDecode(response.body) as List)
        .map((data) => SavedpostModel.fromJson(data as Map<String, dynamic>))
        .toList();
    emit(FetchSavedpostSuccessState(savedposts: savedPosts));
    } else if (response.statusCode == 500) {
      emit(FetchSavedpostInternalErrorState());
    }
  }
}
