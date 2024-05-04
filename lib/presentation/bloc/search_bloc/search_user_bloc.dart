import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:social_media_app/data/models/searchuser_mdel.dart';
import 'package:social_media_app/domain/repository/post_repo.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  SearchUserBloc() : super(SearchUserInitial()) {
    on<SearchUserEvent>((event, emit) {});
    on<SearchUserInitialEvent>(searchinitialevent);
  }

  FutureOr<void> searchinitialevent(
      SearchUserInitialEvent event, Emitter<SearchUserState> emit) async {
    emit(SearchUserLoadingState());
    final Response response =
        await PostRepo.searchusers(searchquery: event.searchquery);

  List<SearcUserModel> searchusers = [];
    if (response.statusCode == 200) {
      final List<dynamic> responsedata = jsonDecode(response.body);
      for (int i = 0; i < responsedata.length; i++) {
        SearcUserModel searchuser =
            SearcUserModel.fromJson(responsedata[i] as Map<String, dynamic>);
        searchusers.add(searchuser);
      }
      emit(SearchUserSuccessState(searchuser: searchusers));
    } else if (response.statusCode == 500) {
      emit(SearchUserInternalErrorState());
    }
  }
}
