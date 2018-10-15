part of quill;

class Time {
  final Duration duration;
  Time(this.duration);
  double get elapsedSeconds {
    return (duration.inMicroseconds / Duration.microsecondsPerSecond).abs();
  }
}
