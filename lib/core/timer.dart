part of quill;

/// The timer class is used to cause events to be triggered
/// when the time is up.

/// This needs to be made into a component.

class Timer {
  /// Increment is increased until it is equal-to or greater-than
  /// the duration.
  double increment = 0.0;

  /// The duration, in seconds for when the timer should complete.
  double duration;

  /// Create the Timer by the duration
  Timer(this.duration);

  /// Increment the timer and return [true|false] one whether it
  /// has completed.
  bool completed(Time time) {
    increment += time.elapsedSeconds;
    if (increment >= duration) {
      return true;
    }
    return false;
  }

  /// Reset the timer increment to 0.0
  void reset() {
    increment = 0.0;
  }
}
