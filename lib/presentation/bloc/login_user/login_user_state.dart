part of 'login_user_bloc.dart';

@immutable
sealed class LoginUserState {}

final class LoginUserInitial extends LoginUserState {}

final class LoginUserLoadingState extends LoginUserState {}

final class LoginUserSuccessState extends LoginUserState {
  final Loginuser loginuserdata;

  LoginUserSuccessState({required this.loginuserdata});
}
final class LoginUserErrorStateInternalServerError extends LoginUserState{}
final class LOginUserErrorState extends LoginUserState{}