part of quill;

class Feather {
  final Map<String, Feather> feathers = new Map<String, Feather>();
  Feather parent;
  String name;

  void init() {
    // for (final feather in feathers.values) {
    //   feather.init();
    // }
  }

  void dispose() {
    for (final feather in feathers.values) {
      feather.dispose();
    }
  }

  void load() {
    for (final feather in feathers.values) {
      feather.load();
    }
  }

  void unload() {
    for (final feather in feathers.values) {
      feather.unload();
    }
  }

  void input(Event event) {
    for (final feather in feathers.values) {
      feather.input(event);
    }
  }

  void update(Time time) {
    for (final feather in feathers.values) {
      feather.update(time);
    }
  }

  void render(Context context) {
    for (final feather in feathers.values) {
      feather.render(context);
    }
  }

  T addFeather<T extends Feather>(String name, [Feather feather]) {
    if (feathers[name] == null) {
      feathers[name] = (feather != null) ? feather : new Feather();
      feathers[name].parent = this;
      feathers[name].name = name;
      feathers[name].init();
    }
    return feathers[name];
  }

  void removeFeather(String name) {
    if (feathers[name] != null) {
      feathers[name].unload();
      feathers[name].dispose();
      feathers[name] = null;
      feathers.remove(name);
    }
  }

  T getFeather<T extends Feather>(String name) {
    if (feathers[name] != null) {
      return feathers[name];
    }
    return null;
  }

  @override
  String toString() {
    return 'Feather "$name" : Child of "${parent.name}"';
  }
}
