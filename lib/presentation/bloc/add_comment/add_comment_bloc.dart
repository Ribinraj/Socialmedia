import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/domain/repository/post_repo.dart';

part 'add_comment_event.dart';
part 'add_comment_state.dart';

class AddCommentBloc extends Bloc<AddCommentEvent, AddCommentState> {
  AddCommentBloc() : super(AddCommentInitial()) {
    on<AddCommentEvent>((event, emit) {});
    on<AddCommentClickEvent>(addcommentevent);
  }

  FutureOr<void> addcommentevent(
      AddCommentClickEvent event, Emitter<AddCommentState> emit) async {
    emit(AddcommentLoadingState());
    String response = await PostRepo.addcomments(
        userId: event.userId,
        userName: event.userName,
        postId: event.postId,
        content: event.content);
    debugPrint(response);
    if (response == 'comment added successfully') {
      emit(AddcommentSuccessState());
    } else if (response == 'internalserver error') {
      emit(AddcommentInternalErrorState());
    }
  }
}
