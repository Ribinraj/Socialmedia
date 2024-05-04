import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';


part 'isfollowing_event.dart';
part 'isfollowing_state.dart';

class IsfollowingBloc extends Bloc<IsfollowingEvent, IsfollowingState> {
  IsfollowingBloc() : super(IsfollowingInitial()) {
    on<IsfollowingEvent>((event, emit) {});
    on<IsfollowingInitialEvent>(isfollowinginitialevent);
  }
  

  FutureOr<void> isfollowinginitialevent(IsfollowingInitialEvent event, Emitter<IsfollowingState> emit) async{
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
