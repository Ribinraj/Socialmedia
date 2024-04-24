import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_comment_event.dart';
part 'delete_comment_state.dart';

class DeleteCommentBloc extends Bloc<DeleteCommentEvent, DeleteCommentState> {
  DeleteCommentBloc() : super(DeleteCommentInitial()) {
    on<DeleteCommentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
