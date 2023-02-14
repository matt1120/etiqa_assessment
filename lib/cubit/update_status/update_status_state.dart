part of 'update_status_cubit.dart';

@immutable
abstract class UpdateStatusState {}

class UpdateStatusInitial extends UpdateStatusState {}

class UpdateStatusSuccess extends UpdateStatusState {}

class UpdateStatusFail extends UpdateStatusState {}