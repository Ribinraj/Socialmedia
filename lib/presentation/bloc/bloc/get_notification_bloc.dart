import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'package:social_media_app/data/models/notification_model.dart';

import 'package:social_media_app/domain/repository/user_repo.dart';

part 'get_notification_event.dart';
part 'get_notification_state.dart';

class GetNotificationBloc
    extends Bloc<GetNotificationEvent, GetNotificationState> {
  GetNotificationBloc() : super(GetNotificationInitial()) {
    on<GetNotificationEvent>((event, emit) {});
    on<GetnotificationInitialEvent>(getnotificationevent);
  }

  FutureOr<void> getnotificationevent(GetnotificationInitialEvent event,
      Emitter<GetNotificationState> emit) async {
    emit(GetNotificationLoadingState());
    final Response response = await LoginUserRepo.getnotification();
    debugPrint(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      List<NotificationModel> notifications =
          responseData.map((json) => NotificationModel.fromJson(json)).toList();

      emit(GetNotificationSuccessState(notifications: notifications));
    } else {
      emit(GetNotificationErrorState());
    }
  }
}
