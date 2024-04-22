part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

final class EditprofileClickEvent extends EditProfileEvent {
  final String? name;
  final String? bio;
  final String? imageurl;
  final File? image;
  final String? backgroundImageurl;
  final File? backgroundImage;

  EditprofileClickEvent( 
      {this.name, this.bio, this.imageurl, this.image,this.backgroundImageurl, this.backgroundImage});
}
