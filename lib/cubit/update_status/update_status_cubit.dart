import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../db/tododb.dart';

part 'update_status_state.dart';

class UpdateStatusCubit extends Cubit<UpdateStatusState> {
  UpdateStatusCubit() : super(UpdateStatusInitial());

  Future<void> updateStatus(int id) async {
    try {
      final result = await TodoDB.instance.updateStatus("Complete", id);
      if (result == "success") {
        emit(UpdateStatusSuccess());
      } else {
        emit(UpdateStatusFail());
      }
    } catch (e) {
      emit(UpdateStatusFail());
      log(e.toString());
    }
  }
}
