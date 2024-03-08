import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeIndexCubit extends Cubit<int> {
  ChangeIndexCubit() : super(0);

  void changeIndexEvent(int newValue) => emit(newValue);
}
