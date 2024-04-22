import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/domain/repository/user_repo.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<EditProfileEvent>((event, emit) {});
    on<EditprofileClickEvent>(editprofileevent);
  }

  FutureOr<void> editprofileevent(
      EditprofileClickEvent event, Emitter<EditProfileState> emit) async {
    emit(EditProfileLoadingState());
    String response = await LoginUserRepo.editprofile(
        image: event.image,
        backgroundImageurl:event.backgroundImageurl,
        backgroundImage:event.backgroundImage,
        imageurl: event.imageurl,
        name: event.name,
        bio: event.bio);
    debugPrint(response);
    if (response == 'data edited successfully') {
      emit(EditProfileSuccessState());
    } else if (response == 'Internal server Error') {
      emit(EditProfileInternalErrorState());
    } else {
      emit(EditProfileErrorState());
    }
  }
}
