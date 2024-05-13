import 'dart:async';
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';


import 'package:social_media_app/domain/repository/user_repo.dart';

part 'connection_count_event.dart';
part 'connection_count_state.dart';

class ConnectionCountBloc
    extends Bloc<ConnectionCountEvent, ConnectionCountState> {
  ConnectionCountBloc() : super(ConnectionCountInitial()) {
    on<ConnectionCountEvent>((event, emit) {});
    on<ConnectionCountInitialEvent>(connectioncountinitialevent);
  }

  FutureOr<void> connectioncountinitialevent(ConnectionCountInitialEvent event,
      Emitter<ConnectionCountState> emit) async {
    emit(ConnectionCountLoadingState());
    final Response response =
        await LoginUserRepo.getconnectioncount(userId: event.userId);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final followersCount = data['followersCount'] as int;
      final followingCount = data['followingCount'] as int;
      emit(ConnectionCountSuccessState(
          followersCount: followersCount, followingCount: followingCount));
    } else {
      ConnectionCountErrorState();
    }
  }
}
