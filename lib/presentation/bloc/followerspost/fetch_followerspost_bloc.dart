import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'package:social_media_app/data/models/followers_post.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';

part 'fetch_followerspost_event.dart';
part 'fetch_followerspost_state.dart';

class FetchFollowerspostBloc
    extends Bloc<FetchFollowerspostEvent, FetchFollowerspostState> {
  FetchFollowerspostBloc() : super(FetchFollowerspostInitial()) {
    on<FetchFollowerspostEvent>((event, emit) {});
    on<InitialFetchingEventFollowersPost>(fetchingeventfollowerspost);
    on<LoadMoreFollowersPostsEvent>((event, emit) => _loadMore(event, emit));
  }

  FutureOr<void> fetchingeventfollowerspost(
      InitialFetchingEventFollowersPost event,
      Emitter<FetchFollowerspostState> emit) async {
    emit(FetchFollowersPostLoadingState());
    final Response response = await PostRepo.fetchfollowespost(n: event.n);
    List<FollowerspostModel> followersposts = [];

    if (response.statusCode == 200) {
      final List<dynamic> responsedata = jsonDecode(response.body);
      for (int i = 0; i < responsedata.length; i++) {
        FollowerspostModel followerspost = FollowerspostModel.fromJson(
            responsedata[i] as Map<String, dynamic>);
        followersposts.add(followerspost);
      }
      emit(FetchFollowersPostSuccessState(followersposts: followersposts));
    } else if (response.statusCode == 500) {
      emit(FetchFollowersPostInternalErrorstate());
    } else {
      emit(FetchFollowerPostErrorState());
    }
  }
  
  Future<void> _loadMore(
    LoadMoreFollowersPostsEvent event,
    Emitter<FetchFollowerspostState> emit,
  ) async {
    if (state is FetchFollowersPostSuccessState) {
      final currentState = state as FetchFollowersPostSuccessState;
      final int currentPage = currentState.followersposts.length ~/ 5 + 1; 

      final Response response = await PostRepo.fetchfollowespost(n: currentPage);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        List<FollowerspostModel> newPosts = [];

        for (int i = 0; i < responseData.length; i++) {
          FollowerspostModel followersPost = FollowerspostModel.fromJson(responseData[i] as Map<String, dynamic>);
          newPosts.add(followersPost);
        }

        List<FollowerspostModel> updatedPosts = List.of(currentState.followersposts)..addAll(newPosts);
        emit(FetchFollowersPostSuccessState(followersposts: updatedPosts));
      } else {
        emit(FetchFollowerPostErrorState());
      }
    }
  }
}

