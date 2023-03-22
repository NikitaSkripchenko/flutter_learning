import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:oneteatree/domain/data_providers/timer_provider.dart';
import 'package:oneteatree/domain/entities/timer.dart';

class TimerState {
  final Timer currentTimer;

  const TimerState({
    required this.currentTimer,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimerState &&
          runtimeType == other.runtimeType &&
          currentTimer == other.currentTimer);

  @override
  int get hashCode => currentTimer.hashCode;

  @override
  String toString() {
    return 'UsersState{ currentUser: $currentTimer }';
  }

  TimerState copyWith({
    Timer? currentTimer,
  }) {
    return TimerState(
      currentTimer: currentTimer ?? this.currentTimer,
    );
  }
}

abstract class TimerEvents {}

class TimerInitializeEvent implements TimerEvents {}

class TimerStartEvent implements TimerEvents {}

class TimerPauseEvent implements TimerEvents {}

class UsersBloc extends Bloc<TimerEvents, TimerState> {
  final _timerDataProvider = TimerDataProvider();

  UsersBloc() : super(TimerState(currentTimer: Timer(0, 0))) {
    on<TimerInitializeEvent>((event, emit) async {
      final timer = await _timerDataProvider.loadValue();
      emit(TimerState(currentTimer: timer));
    });

    on<TimerStartEvent>((event, emit) {});
    // on<UsersEvents>(
    //   (event, emit) async {
    //     if (event is TimerInitializeEvent) {
    //       final user = await _userDataProvider.loadValue();
    //       emit(TimerState(currentTimer: user));
    //     } else if (event is UsersIncrementEvent) {
    //       var user = state.currentTimer;
    //       user = user.copyWith(age: user.age + 1);
    //       await _userDataProvider.saveValue(user);
    //       emit(TimerState(currentTimer: user));
    //     } else if (event is UsersDecrementEvent) {
    //       var user = state.currentTimer;
    //       user = user.copyWith(age: user.age - 1);
    //       await _userDataProvider.saveValue(user);
    //       emit(TimerState(currentTimer: user));
    //     }
    //   },
    //   transformer: sequential(),
    // );
  }
}
