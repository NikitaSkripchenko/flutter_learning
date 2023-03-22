class Timer {
  final double initial;
  final double increment;

  Timer(this.initial, this.increment);

  Timer copyWith({double? initial, double? increment}) {
    return Timer(initial ?? this.initial, increment ?? this.increment);
  }
}
