import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final response = await LoginUserRepo.fetchloginuser();
    if (response != null) {
      emit(LoginUserSuccessState(loginuserdata: response));
    } else if (response == null) {
      emit(LoginUserErrorStateInternalServerError());
    } else {
      emit(LOginUserErrorState());
    }
  }
}
