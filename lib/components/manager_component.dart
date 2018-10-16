part of quill;

/// Does the manager component only allow for 1 active feather at a time?
/// perhaps have a separate component for multiple active feathers

class ManagerComponent extends Component {
  /// If this is set, then only ONE feather will be displayed
  String currentFeather;

  void activate(String name) {
    quill.getFeather(name).active = true;
  }

  void deactivate(String name) {
    quill.getFeather(name).active = false;
  }

  /// This will disable all feathers not matching `name`
  void singleActive(String name) {
    for (String key in quill.feathers.keys) {
      quill.getFeather(name).active = key == name;
    }
  }

  void setCurrentdisable(String name) {
    if (currentFeather != name) {
      currentFeather = name;
      singleActive(name);
    }
  }

  String getCurrent() {
    return currentFeather;
  }
}
