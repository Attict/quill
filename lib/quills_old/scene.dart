part of quill;

class Scene extends Quill {
  bool initialized = false;
  bool fixedPosition = false;

  set origin(Origin origin) { 
    position.origin = origin;
  }
  
  PositionComponent _position;
  PositionComponent get position {
    if (_position == null) {
      PositionComponent position = getComponent<PositionComponent>();
      if (position == null) {
        position = addComponent<PositionComponent>(new PositionComponent());
      }
      _position = position;
    }
    return _position;
  }

  SizeComponent _size;
  SizeComponent get size {
    if (_size == null) {
      SizeComponent size = getComponent<SizeComponent>();
      if (size == null) {
        size = addComponent<SizeComponent>(new SizeComponent());
      }
      _size = size;
    }
    return _size;
  }

  get camera => getComponent<CameraComponent>();

  void initWithBackground(Color color, {Texture texture}) {
    if (!initialized) {
      addComponent<ColorComponent>(new ColorComponent())..setColor(color);
      initialized = true;
    }
  }

  void setSize(double width, double height) {
    if (!hasComponent<SizeComponent>()) {
      addComponent<SizeComponent>(new SizeComponent());
    }
    size.setSize(width, height);
  }

  void setPosition(double x, double y) {
    PositionComponent position = this.position;
    if (position == null) {
      position = addComponent<PositionComponent>(new PositionComponent());
    }
    position.setPosition(x, y);
  }

  @Deprecated('To be removed in version 0.3')
  void translate(double x, double y) => translateCamera(x, y);

  void translateCamera(double x, double y) {
    if (camera == null) {
      addComponent<CameraComponent>(new CameraComponent());
    }
    setCameraTranslate(camera.x + x, camera.y + y);
  }

  void setCameraTranslate(double x, double y) {
    if (camera == null) {
      addComponent<CameraComponent>(new CameraComponent());
    }
    camera.translate(x, y);
    if (fixedPosition) {
      setPosition(x + position.x, y + position.y);
    }
  }

  void setCameraScale(double x, double y) {
    if (camera == null) {
      addComponent<CameraComponent>(new CameraComponent());
    }
    camera.scale(x, y);
  }


}
