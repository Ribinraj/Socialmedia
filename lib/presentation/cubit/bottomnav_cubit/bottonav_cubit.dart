import 'package:flutter_bloc/flutter_bloc.dart';

class BottomnavCubit extends Cubit<int> {
  BottomnavCubit() : super(0);
  void onpageChanged(int value) {
    emit(value);
  }
}
