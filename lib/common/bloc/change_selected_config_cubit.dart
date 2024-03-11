import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeSelectedConfigCubit extends Cubit<int> {
  ChangeSelectedConfigCubit() : super(0);

  void changeSelectedConfigEvent(int newValue) => emit(newValue);
}
