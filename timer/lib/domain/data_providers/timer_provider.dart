import "package:oneteatree/domain/entities/timer.dart";
import 'package:shared_preferences/shared_preferences.dart';

class TimerDataProvider {
  final sharedPreferences = SharedPreferences.getInstance();
  var imitationCounter = 0;

  Future<Timer> loadValue() async {
    final initial = (await sharedPreferences).getDouble('initial') ?? 0;
    final increment = (await sharedPreferences).getDouble('increment') ?? 0;
    return Timer(initial, increment);
  }

  Future<void> saveValue(Timer timer) async {
    (await sharedPreferences).setDouble('increment', timer.increment);
    (await sharedPreferences).setDouble('initial', timer.initial);
  }
}
