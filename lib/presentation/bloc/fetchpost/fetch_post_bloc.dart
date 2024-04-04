import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/data/models/post_model.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';

part 'fetch_post_event.dart';
part 'fetch_post_state.dart';

class FetchPostBloc extends Bloc<FetchPostEvent, FetchPostState> {
  FetchPostBloc() : super(FetchPostInitial()) {
    on<FetchPostEvent>((event, emit) {});
    on<FetchPostInitialEvent>(fetchpostevent);
  }

  FutureOr<void> fetchpostevent(
      FetchPostInitialEvent event, Emitter<FetchPostState> emit) async {
 emit(FetchPostLoadingState());
    final Response response = await PostRepo.fetchPost();
   

    List<Postmodel> posts = [];
    if (response.statusCode == 200) {
      final List<dynamic> responsedata =
          jsonDecode(response.body); // Expecting a List
      for (int i = 0; i < responsedata.length; i++) {
        // Iterate over the list
        Postmodel post =
            Postmodel.fromJson(responsedata[i] as Map<String, dynamic>);
        posts.add(post);
      }
      emit(FetchPostSuccessState(posts: posts));
    } else if (response.statusCode == 500) {
      emit(FetchPostErrorStateInternalserverError());
    } else {
      emit(FetchPostErrorState());
    }
  }
}
