import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/data/models/signup_model.dart';
import 'package:social_media_app/domain/repository/signup_repo.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>((event, emit) {});
    on<SignupButtenClickEvent>(signupevent);
  }

  FutureOr<void> signupevent(
      SignupButtenClickEvent event, Emitter<SignupState> emit) async {
    String response = await SignupRepo.signupuser(user: event.user);
    debugPrint(response);
    emit(SignupLoadingState());

    if (response == 'Successful') {
      emit(SignupSuccessState());
    } else if (response == 'You already have an account') {
      emit(SignupErrorStateAlreadyAccount());
    } else if (response == 'OTP already sent within the last one minute') {
      emit(SignupErrorStateOtpalreadySent());
    } else if (response == 'Internal server Error') {
      emit(SignupErrorStateInternalServerError());
    } else {
      emit(SignupErrorState());
    }
  }
}
