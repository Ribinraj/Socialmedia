import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';

part 'comment_delete_event.dart';
part 'comment_delete_state.dart';

class CommentDeleteBloc extends Bloc<CommentDeleteEvent, CommentDeleteState> {
  CommentDeleteBloc() : super(CommentDeleteInitial()) {
    on<CommentDeleteEvent>((event, emit) {});
    on<CommentDeleteClickEvent>(commentdeleteevent);
  }

  FutureOr<void> commentdeleteevent(
      CommentDeleteClickEvent event, Emitter<CommentDeleteState> emit) async {
    var response = await PostRepo.deletecomment(commentid: event.commentId);
    if (response == 'comment deleted successfully') {
      emit(CommentDeleteSuccessState());
    } else if (response == 'internal server error') {
      emit(CommentDeleteInternalErrorState());
    }
  }
}
