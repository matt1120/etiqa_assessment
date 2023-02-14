import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollControllerCubit extends Cubit<bool> {
  ScrollControllerCubit() : super(true);

  void isVisible(bool visible) => emit(visible);
}
