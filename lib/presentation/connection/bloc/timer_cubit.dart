import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<String> {
  Timer? _timer;
  int _seconds = 0;

  TimerCubit() : super('00:00:00');

  void start() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _seconds++;
        final hours = _seconds ~/ 3600;
        final minutes = (_seconds ~/ 60) % 60;
        final seconds = _seconds % 60;
        emit(
            '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}');
      });
    }
  }

  void reset() {
    _timer?.cancel();
    _seconds = 0;
    emit('00:00:00');
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
