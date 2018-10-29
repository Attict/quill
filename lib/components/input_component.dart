part of quill;

class InputComponent extends Component {
  final List<int> eventTypes = new List<int>();
  final List<VoidCallback> callbacks = new List<VoidCallback>();

  @override
  void input(Event event) {
    super.input(event);

    /// If event.type matches any of the events.type
    /// and the event is within the bounds of position & size
    /// trigger callback
    PositionComponent position = quill.getComponent<PositionComponent>();
    SizeComponent size = quill.getComponent<SizeComponent>();

    for (int i = 0; i < callbacks.length; i++) {
      if (eventTypes[i] == event.type) {
        if (position == null || size == null) {
          callbacks[i]();
        } else {
          double left = position.x - size.width / 2;
          double top = position.y - size.height / 2;
          double right = position.x + size.width / 2;
          double bottom = position.y + size.width / 2;

          /// This should be using the baseX and baseY, but for some reason,
          /// it only works with this setup.  For now skipping.
          if (left <= event.position.x &&
              event.position.x <= right &&
              top <= event.position.y &&
              event.position.y <= bottom) {
            callbacks[i]();
          }
        }
      }
    }
  }

  void addEvent(int type, VoidCallback callback) {
    eventTypes.add(type);
    callbacks.add(callback);
  }
}
