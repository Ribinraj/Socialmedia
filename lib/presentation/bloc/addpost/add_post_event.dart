part of 'add_post_bloc.dart';

@immutable
sealed class AddPostEvent {}

final class AddPostClickEvent extends AddPostEvent {
  final AssetEntity image;
  final String description;

  AddPostClickEvent({required this.image, required this.description});
}
