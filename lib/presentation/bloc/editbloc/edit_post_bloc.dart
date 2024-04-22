import 'dart:async';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:social_media_app/domain/repository/post_repo.dart';

part 'edit_post_event.dart';
part 'edit_post_state.dart';

class EditPostBloc extends Bloc<EditPostEvent, EditPostState> {
  EditPostBloc() : super(EditPostInitial()) {
    on<EditPostEvent>((event, emit) {});
    on<EditPostClickevent>(editpostevent);
  }

  FutureOr<void> editpostevent(
      EditPostClickevent event, Emitter<EditPostState> emit) async {
         emit(EditPostLoadingState());
    String response = await PostRepo.editpost(
      image:event.image,
        imageurl: event.imageurl,
        description: event.description,
        postid: event.postid);
    debugPrint(response);
   
    if (response == 'Post edited Successfully') {
      emit(EditPostSuccessState());
    } else if (response == 'Internal Server Error') {
      emit(EditpostErrorStateInternalServerError());
    } else {
      emit(EditpostErrorState());
    }
  }
}
