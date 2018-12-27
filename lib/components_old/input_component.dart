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

    print('${position.x}, ${position.y}, ${size.width}, ${size.height}');


    for (int i = 0; i < callbacks.length; i++) {
      if (eventTypes[i] == event.type) {
        if (position == null || size == null) {
          callbacks[i]();
        } else {
          double left = position.drawAt.x;
          double top = position.drawAt.y;
          double right = (position.drawAt.x + size.width);
          double bottom = (position.drawAt.y + size.height);

          /// This should be using the baseX and baseY, but for some reason,
          /// it only works with this setup.  For now skipping.
          if (Context.scale.y == 1) {
            if (left <= event.position.x &&
                event.position.x <= right &&
                top <= event.position.y &&
                event.position.y <= bottom) {
              callbacks[i]();
            }
          } else {
            if (left <= event.position.x &&
                event.position.x <= right &&
                bottom <= event.position.y &&
                event.position.y <= top) {
              callbacks[i]();
            }
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
