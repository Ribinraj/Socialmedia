import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/data/models/following_model.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';

part 'fetch_followings_event.dart';
part 'fetch_followings_state.dart';

class FetchFollowingsBloc
    extends Bloc<FetchFollowingsEvent, FetchFollowingsState> {
  FetchFollowingsBloc() : super(FetchFollowingsInitial()) {
    on<FetchFollowingsEvent>((event, emit) {});
    on<FetchFollowingInitialEvent>(fetchfollowingevent);
  }

  FutureOr<void> fetchfollowingevent(FetchFollowingInitialEvent event,
      Emitter<FetchFollowingsState> emit) async {
    emit(FetchFollowingLoadingState());
    final Response response = await PostRepo.fetchfollowing();
    
    if (response.statusCode == 200) {
     
       final Map<String, dynamic> responsedata = jsonDecode(response.body);
      FollowingModel followings =
          FollowingModel.fromJson(responsedata);
    
      emit(FetchFollowingSuccessState(followings: followings));
    } else if (response.statusCode == 500) {
      emit(FetchFollowingInternalErrorState());
    }
  }
}
