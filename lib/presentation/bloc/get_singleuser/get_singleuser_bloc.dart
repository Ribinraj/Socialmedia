import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'package:social_media_app/data/models/get_singleuser_model.dart';
import 'package:social_media_app/domain/repository/user_repo.dart';

part 'get_singleuser_event.dart';
part 'get_singleuser_state.dart';

class GetSingleuserBloc extends Bloc<GetSingleuserEvent, GetSingleuserState> {
  GetSingleuserBloc() : super(GetSingleuserInitial()) {
    on<GetSingleuserEvent>((event, emit) {});
    on<GetSingleUserInitialFetchEvent>(getsingleuserinitialfetchevent);
  }

  FutureOr<void> getsingleuserinitialfetchevent(
      GetSingleUserInitialFetchEvent event,
      Emitter<GetSingleuserState> emit) async {
    emit(GetSingleuserLoadingState());
    final Response response =
        await LoginUserRepo.getsingleuser(userId: event.userId);
    if (response.statusCode == 200) {
      final responsebody = jsonDecode(response.body);
      final GetUserModel user = GetUserModel.fromJson(responsebody);
      emit(GetSingleuserSuccessState(user: user));
    } else {
      emit(GetSingleUserErrorState());
    }
  }
}
