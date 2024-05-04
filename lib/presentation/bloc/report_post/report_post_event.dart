part of 'report_post_bloc.dart';

@immutable
sealed class ReportPostEvent {}

final class ReportpostClickEvent extends ReportPostEvent {
  final String postId;

  final String reportType;

  ReportpostClickEvent({required this.postId, required this.reportType});
  


}
