part of quill;

class Quill extends Feather {
  List<Component> _components = new List<Component>();

  @override
  void init() {
    for (final component in _components) {
      component.init();
    }
    super.init();
  }

  @override
  void dispose() {
    for (final component in _components) {
      component.dispose();
    }
    super.dispose();
  }

  @override
  void load() {
    for (final component in _components) {
      component.load();
    }
    super.load();
  }

  @override
  void unload() {
    for (final component in _components) {
      component.unload();
    }
    super.unload();
  }

  @override
  void input(Event event) {
    for (final component in _components) {
      component.input(event);
    }
    super.input(event);
  }

  @override
  void update(Time time) {
    for (final component in _components) {
      component.update(time);
    }
    super.update(time);
  }

  @override
  void render(Context context) {
    for (final component in _components) {
      component.render(context);
    }
    super.render(context);
  }

  T addComponent<T extends Component>(T component) {
    if (!hasComponent<T>()) {
      component.quill = this;
      _components.add(component);
      return component;
    }
    return getComponent<T>();
  }

  void removeComponent<T extends Component>() {
    Component component = getComponent<T>();
    if (component != null) {
      component.dispose();
      _components.remove(component);
    }
  }

  T getComponent<T extends Component>() {
    for (final component in _components) {
      if (component is T) {
        return component;
      }
    }
    return null;
  }

  bool hasComponent<T extends Component>() {
    if (getComponent<T>() != null) {
      return true;
    }
    return false;
  }
}
