part of 'image_picker_bloc.dart';

@immutable
sealed class ImagePickerEvent {}

final class AddImageEvent extends ImagePickerEvent {
  final String image;

  AddImageEvent({required this.image});
}
