import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'package:social_media_app/data/models/comments_model.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';

part 'fetch_comment_event.dart';
part 'fetch_comment_state.dart';

class FetchCommentBloc extends Bloc<FetchCommentEvent, FetchCommentState> {
  FetchCommentBloc() : super(FetchCommentInitial()) {
    on<FetchCommentEvent>((event, emit) {});
    on<FetchCommentInitialEvent>(fetchcommentevent);
  }

  FutureOr<void> fetchcommentevent(
      FetchCommentInitialEvent event, Emitter<FetchCommentState> emit) async {
    emit(FetchCommentLoadingState());
    final Response response =
        await PostRepo.fetchcomments(postid: event.postId);
    // List<CommentModel> comments = [];
    if (response.statusCode == 200) {
      final responsedata = jsonDecode(response.body);
      List<CommentModel> comments = List<CommentModel>.from(
          responsedata['comments']
              .map((commentJson) => CommentModel.fromJson(commentJson)));
      // for (var i = 0; i < responsedata.length; i++) {
      //   CommentModel comment = CommentModel.fromJson(responsedata[i]);
      //   comments.add(comment);
      // }
      emit(FetchCommentSuccessState(comments: comments));
    } else if (response.statusCode == 500) {
      emit(FetchCommentInternalserverErrorState());
    }
  }
}
