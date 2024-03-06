import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_config_event.dart';
import 'add_config_state.dart';

class AddConfigBloc extends Bloc<AddConfigEvent, AddConfigState> {
  AddConfigBloc() : super(AddConfigState()) {
    on<AddConfigEvent>((event, emit) {
      emit(AddConfigState());
    });
  }
}
