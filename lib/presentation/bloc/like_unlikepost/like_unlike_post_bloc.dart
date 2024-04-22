import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/domain/repository/post_repo.dart';

part 'like_unlike_post_event.dart';
part 'like_unlike_post_state.dart';

class LikeUnlikePostBloc
    extends Bloc<LikeUnlikePostEvent, LikeUnlikePostState> {
  LikeUnlikePostBloc() : super(LikeUnlikePostInitial()) {
    on<LikeUnlikePostEvent>((event, emit) {});
    on<LikepostEvent>(likepost);
    on<UnlikePostEvent>(unlikepost);
  }

  FutureOr<void> likepost(
      LikepostEvent event, Emitter<LikeUnlikePostState> emit) async {
    String response = await PostRepo.postlike(postId: event.postid);
    debugPrint(response);
    if (response == 'post liked successfully') {
      emit(LikedPostState());
    } else {
      emit(InternalErrorState());
    }
  }

  FutureOr<void> unlikepost(UnlikePostEvent event, Emitter<LikeUnlikePostState> emit)async {
       String response = await PostRepo.postunlike(postId: event.postid);
    debugPrint(response);
    if (response == 'post unliked successfully') {
      emit(LikedPostState());
    } else {
      emit(InternalErrorState());
    }
  }
}
