part of 'report_post_bloc.dart';

@immutable
sealed class ReportPostState {}

final class ReportPostInitial extends ReportPostState {}
final class ReportPostSuccessState extends ReportPostState{}
final class ReportPostInternalServerError extends ReportPostState{}