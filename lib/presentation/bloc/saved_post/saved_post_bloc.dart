import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';

part 'saved_post_event.dart';
part 'saved_post_state.dart';

class SavedPostBloc extends Bloc<SavedPostEvent, SavedPostState> {
  SavedPostBloc() : super(SavedPostInitial()) {
    on<SavedPostEvent>((event, emit) {});
    on<SavedpostClickEvent>(savedpostevent);
    on<UnsavedPostClickEvent>(unsavedpostevent);
  }

  FutureOr<void> savedpostevent(
      SavedpostClickEvent event, Emitter<SavedPostState> emit) async {
    var response = await PostRepo.savepost(postId: event.postId);
    if (response == 'data saved successfully') {
      emit(SavedPostSuccessState());
    } else if (response == 'internal server error') {
      emit(SavedPostInternalErrorState());
    }
  }

  FutureOr<void> unsavedpostevent(
      UnsavedPostClickEvent event, Emitter<SavedPostState> emit) async {
    var response = await PostRepo.unsavepost(postId: event.postId);
    if (response == 'post unsaved Successfully') {
      emit(UnsavedpostSuccessState());
    } else if (response == 'internal server error') {
      emit(UnsavedpostInternalErrorState());
    }
  }
}
