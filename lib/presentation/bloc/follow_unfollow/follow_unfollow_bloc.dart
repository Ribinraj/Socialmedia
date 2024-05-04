import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';


part 'follow_unfollow_event.dart';
part 'follow_unfollow_state.dart';

class FollowUnfollowBloc
    extends Bloc<FollowUnfollowEvent, FollowUnfollowState> {
  FollowUnfollowBloc() : super(FollowUnfollowInitial()) {
    on<FollowUnfollowEvent>((event, emit) {});
    on<FollowButtonClickEvent>(followingevent);
    on<UnFollowButtonClickEvent>(unfollowingevent);
    on<IsfollowingInitialEvent>(isfollowinginitialevent);
  }

  FutureOr<void> followingevent(
      FollowButtonClickEvent event, Emitter<FollowUnfollowState> emit) async {
    var response = await PostRepo.followuser(followeeId: event.followeeId);
    if (response == 'followed Successfully') {
      emit(FollowuserSuccessState());
    } else if (response == 'internal server error') {
      emit(FollowuserInternalErrorState());
    }
  }

  FutureOr<void> unfollowingevent(
      UnFollowButtonClickEvent event, Emitter<FollowUnfollowState> emit) async {
    var response =
        await PostRepo.unfollowuser(unfolloweeId: event.unfolloweeId);
    if (response == 'unfollowed Successfully') {
      emit(UnfollowuserSuccessState());
    } else if (response == 'internal server error') {
      emit(UnfollowuserInternalErrorState());
    }
  }

  FutureOr<void> isfollowinginitialevent(
      IsfollowingInitialEvent event, Emitter<FollowUnfollowState> emit) async {
    final Response response = await PostRepo.isfollowing(userId: event.userId);
    final bool isfollowing = jsonDecode(response.body) as bool;
    if (response.statusCode == 200) {
      emit(IsfollowingSuccessState(isfollowing: isfollowing));
    }
    if (response.statusCode == 500) {
      emit(IsfollowInternalErrorState());
    }
  }
}
