part of quill;

class Scene extends Quill {
  @override
  void init() {
    super.init();
    addComponent<CameraComponent>(new CameraComponent());
  }

  CameraComponent _camera;
  CameraComponent get camera {
    if (_camera == null) {
      _camera = getComponent<CameraComponent>();
    }
    return _camera;
  }

  void setTranslate(double x, double y) {
    camera.setTranslate(x, y);
  }

  void setScale(double x, double y) {
    camera.setScale(x, y);
  }

  Sprite addSprite(String name, Sprite sprite) {
    addFeather(name, sprite);
    return sprite;
  }

  Sprite getSprite(String name) {
    return getFeather(name) as Sprite;
  }
}
