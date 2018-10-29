part of quill;

class TimerComponent extends Component {
  final Map<String, Timer> timers = new Map<String, Timer>();
  final Map<String, VoidCallback> callbacks = new Map<String, VoidCallback>();

  @override
  void update(Time time) {
    super.update(time);
    //for (final key in timers.keys) {
    //  if (timers[key].complete(time)) {
    //    callback[key]();
    //  }
    //}
  }

  void addTimer(String name, Timer timer, VoidCallback callback) {
    timers[name] = timer;
  }

  void removeTimer(String name) {
    timers[name] = null;
  }
}
