import 'package:flutter_bloc/flutter_bloc.dart';

class ReportCubit extends Cubit<String?> {
  ReportCubit() : super(null);

  void selectReason(String? reason) {
    emit(reason);
  }
}
