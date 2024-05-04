import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';

part 'report_post_event.dart';
part 'report_post_state.dart';

class ReportPostBloc extends Bloc<ReportPostEvent, ReportPostState> {
  ReportPostBloc() : super(ReportPostInitial()) {
    on<ReportPostEvent>((event, emit) {});
    on<ReportpostClickEvent>(reportpostevent);
  }

  FutureOr<void> reportpostevent(
      ReportpostClickEvent event, Emitter<ReportPostState> emit) async {
    var response = await PostRepo.reportpost(postId: event.postId,  reportType:event.reportType);
    if (response == 'post reported Successfully') {
      emit(ReportPostSuccessState());
    } else if (response == 'Internal Server error') {
      emit(ReportPostInternalServerError());
    }
  }
}
