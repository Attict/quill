part of quill;

class Quill extends Feather {
  List<Component> _components = new List<Component>();

  @override
  void init() {
    super.init();
    for (final component in _components) {
      component.init();
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (final component in _components) {
      component.dispose(); 
    }
  }
  
  @override
  void load() {
    super.load();
    for (final component in _components) {
      component.load(); 
    }
  }

  @override
  void unload() {
    super.unload();
    for (final component in _components) {
      component.unload();
    }
  }

  @override
  void input(Event event) {
    super.input(event);
    for (final component in _components) {
      component.input(event); 
    }
  }

  @override
  void update(Time time) {
    super.update(time);
    for (final component in _components) {
      component.update(time);  
    }
  }

  @override
  void render(Context context) {
    super.render(context);
    for (final component in _components) {
      component.render(context);  
    }
  }

  T addComponent<T extends Component>(T component) {
    if (!hasComponent<T>()) {
      component.quill = this;
      component.init();
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
