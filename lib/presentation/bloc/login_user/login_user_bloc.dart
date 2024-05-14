import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:social_media_app/data/models/loginuser_model.dart';
import 'package:social_media_app/domain/repository/user_repo.dart';

part 'login_user_event.dart';
part 'login_user_state.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  LoginUserBloc() : super(LoginUserInitial()) {
    on<LoginUserEvent>((event, emit) {});
    on<LoginUserInitialFetchingEvent>(loginuserfechingevent);
  }

  FutureOr<void> loginuserfechingevent(
      LoginUserInitialFetchingEvent event, Emitter<LoginUserState> emit) async {
    emit(LoginUserLoadingState());
    final Response response = await LoginUserRepo.fetchloginuser();
    debugPrint('loginuser:${response.body}');
    if (response.statusCode == 200) {
      final responsebody = jsonDecode(response.body);
      final LoginUserModel user = LoginUserModel.fromJson(responsebody);
      emit(LoginUserSuccessState(loginuserdata: user));
    } else {
      emit(LoginUserErrorStateInternalServerError());
    }
  }
}
