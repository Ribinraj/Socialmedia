import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostInitial()) {
    on<AddPostEvent>((event, emit) {});
    on<AddPostClickEvent>(addpostevent);
  }
  FutureOr<void> addpostevent(
      AddPostClickEvent event, Emitter<AddPostState> emit) async {
        emit(AddPostLoadingstate());
    String response = await PostRepo.addpost(
        image: event.image, description: event.description);
    debugPrint(response);
    
    if (response == 'post created successfully') {
      emit(AddPostSuccessState());
    } else if (response ==
        'Something went wrong while saving to the database') {
      emit(AddPostErrorStateDatabaseError());
    } else if (response == 'Something went wrong on the server') {
      emit(AddPostErrorStateInternalServerError());
    } else {
      emit(AddPostErrorState());
    }
  }
}
