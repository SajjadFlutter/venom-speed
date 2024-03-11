// ignore_for_file: unnecessary_null_comparison

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimerCubit extends Cubit<String> {
  Timer? _timer;
  int _seconds = 0;

  TimerCubit() : super('00:00:00');

  void startTime() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          _seconds++;
          final hours = _seconds ~/ 3600;
          final minutes = (_seconds ~/ 60) % 60;
          final seconds = _seconds % 60;
          emit(
              '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}');
        },
      );
    }
  }

  void continueTime() async {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) async {
          int connectionStartTime = await getConnectionStartTime();
          if (connectionStartTime != null) {
            int timeDifference =
                DateTime.now().millisecondsSinceEpoch - connectionStartTime;
            int duration = (timeDifference / 1000).round();

            final hoursDuration = duration ~/ 3600;
            final minutesDuration = (duration ~/ 60) % 60;
            final secondsDuration = duration % 60;

            emit(
                '${_twoDigits(hoursDuration)}:${_twoDigits(minutesDuration)}:${_twoDigits(secondsDuration)}');
          }
        },
      );
    }
  }

  void resetTime() {
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

  Future<int> getConnectionStartTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('connectionStartTime') ?? 0;
  }
}
