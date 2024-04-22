import 'dart:async';


import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/domain/repository/post_repo.dart';

part 'delete_post_event.dart';
part 'delete_post_state.dart';

class DeletePostBloc extends Bloc<DeletePostEvent, DeletePostState> {
  DeletePostBloc() : super(DeletePostInitial()) {
    on<DeletePostEvent>((event, emit) {});
    on<DeletepostClickEvent>(deletepostevent);
  }

  FutureOr<void> deletepostevent(
      DeletepostClickEvent event, Emitter<DeletePostState> emit) async {
    String response = await PostRepo.deletepost(postid: event.postid);
    debugPrint(response);
    if (response == 'post deleted successfully') {
      emit(DeletePostSuccessState());
    } else if (response == 'internal server error') {
      emit(DeletePostInternalServerErrorState());
    } else {
      emit(DeletePostErrorState());
    }
  }
}
