import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerInitial()) {
    on<ImagePickerEvent>((event, emit) {});
    on<AddImageEvent>(addimage);
    on<AddBackgroundImageAddEvent>(addbackgroundimage);
  }

  FutureOr<void> addimage(AddImageEvent event, Emitter<ImagePickerState> emit) {
    emit(ImagePickedState(image: event.image));
  }

  FutureOr<void> addbackgroundimage(
      AddBackgroundImageAddEvent event, Emitter<ImagePickerState> emit) {
    emit(BackgroundImagePickedstate(backgroundimage: event.backgroundimage));
  }
}
