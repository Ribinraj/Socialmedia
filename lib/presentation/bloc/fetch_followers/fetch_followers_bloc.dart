import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:social_media_app/data/models/followers_model.dart';

import 'package:social_media_app/domain/repository/post_repo.dart';

part 'fetch_followers_event.dart';
part 'fetch_followers_state.dart';

class FetchFollowersBloc
    extends Bloc<FetchFollowersEvent, FetchFollowersState> {
  FetchFollowersBloc() : super(FetchFollowersInitial()) {
    on<FetchFollowersEvent>((event, emit) {});
    on<FetchFollowersInitialEvent>(fetchfollowersevent);
  }

  FutureOr<void> fetchfollowersevent(FetchFollowersInitialEvent event, Emitter<FetchFollowersState> emit) async{
        emit(FetchFollowersLoadingState());
    final Response response = await PostRepo.fetchfollowers();
    
    if (response.statusCode == 200) {
     
       final Map<String, dynamic> responsedata = jsonDecode(response.body);
      FollowersModel followers =
          FollowersModel.fromJson(responsedata);
    
      emit(FetchFollowersSuccessState(followers: followers));
    } else if (response.statusCode == 500) {
      emit(FetchFollowersInternalErrorState());
    }
  }
}
