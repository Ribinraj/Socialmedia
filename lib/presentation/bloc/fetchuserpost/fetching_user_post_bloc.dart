import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'package:social_media_app/data/models/post_model.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';

part 'fetching_user_post_event.dart';
part 'fetching_user_post_state.dart';

class FetchingUserPostBloc
    extends Bloc<FetchingUserPostEvent, FetchingUserPostState> {
  FetchingUserPostBloc() : super(FetchingUserPostInitial()) {
    on<FetchingUserPostEvent>((event, emit) {});
    on<FetchingUserpostInitialEvent>(fetchuserpost);
  }

  FutureOr<void> fetchuserpost(FetchingUserpostInitialEvent event,
      Emitter<FetchingUserPostState> emit) async {
         emit(FetchUserPostLoadingState());
    final Response response = await PostRepo.fetchuserpost(userid:event.userId);
    final responsebody = jsonDecode(response.body);
   
    List<Postmodel> userposts = [];
    if (response.statusCode == 200) {
      final List<dynamic> responsedata = jsonDecode(response.body);
      for (int i = 0; i < responsedata.length; i++) {
        Postmodel userpost =
            Postmodel.fromJson(responsedata[i] as Map<String, dynamic>);
        userposts.add(userpost);
      }
      emit(FetchUserPostSuccessState(userposts: userposts));
    } else if (responsebody['message'] == 'User not found') {
      emit(FetchUserPostsErrorUsernoteFoundErrorState());
    } else if (responsebody['message'] ==
        'Something went wrong while updating the post') {
      emit(FetchUserPostsErrorInternalErrorState());
    } else {
      emit(FetchUserPostsErrorState());
    }
  }
}
