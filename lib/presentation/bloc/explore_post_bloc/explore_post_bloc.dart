import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:social_media_app/data/models/explore_model.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';

part 'explore_post_event.dart';
part 'explore_post_state.dart';

class ExplorePostBloc extends Bloc<ExplorePostEvent, ExplorePostState> {
  ExplorePostBloc() : super(ExplorePostInitial()) {
    on<ExplorePostEvent>((event, emit) {});
    on<FetchexplorepostInitialEvent>(explorepostsevent);
  }

  FutureOr<void> explorepostsevent(
      FetchexplorepostInitialEvent event, Emitter<ExplorePostState> emit) async{
          emit(FetchExplorepostLoadingState());
    final Response response = await PostRepo.fetchexplorepost();
   
    if (response.statusCode == 200) {
       List<ExplorepostModel> exploreposts = (jsonDecode(response.body) as List)
        .map((data) => ExplorepostModel.fromJson(data as Map<String, dynamic>))
        .toList();
    emit(FetchexplorepostSuccessState(exploreposts: exploreposts));
    } else if (response.statusCode == 500) {
      emit(FetchSavedpostInternalErrorState());
    }
      }
}
