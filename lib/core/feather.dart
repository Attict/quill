part of quill;

class Feather {
  bool active = true;
  final Map<String, Feather> _feathers = new Map<String, Feather>();
  Map<String, Feather> get feathers => _feathers;
  Feather parent;

  void init() {
    for (final feather in _feathers.values) {
      feather.init();
    }
  }

  void dispose() {
    for (final feather in _feathers.values) {
      feather.dispose();
    }
  }

  void load() {
    for (final feather in _feathers.values) {
      feather.load();
    }
  }

  void unload() {
    for (final feather in _feathers.values) {
      feather.unload();
    }
  }

  void input(Event event) {
    for (final feather in _feathers.values) {
      if (feather.active) {
        feather.input(event);
      }
    }
  }

  void update(Time time) {
    for (final feather in _feathers.values) {
      if (feather.active) {
        feather.update(time);
      }
    }
  }

  void render(Context context) {
    for (final feather in _feathers.values) {
      if (feather.active) {
        feather.render(context);
      }
    }
  }

  T addFeather<T extends Feather>(String name, [Feather feather]) {
    if (_feathers[name] == null) {
      _feathers[name] = (feather != null) ? feather : new Feather();
      _feathers[name].parent = this;
      _feathers[name].init();
    }
    return _feathers[name];
  }

  void removeFeather(String name) {
    if (_feathers[name] != null) {
      _feathers[name].unload();
      _feathers[name].dispose();
      _feathers[name] = null;
      _feathers.remove(name);
    }
  }

  T getFeather<T extends Feather>(String name) {
    if (_feathers[name] != null) {
      return _feathers[name];
    }
    return null;
  }

  @override
  String toString() {
    return '';
  }
}
