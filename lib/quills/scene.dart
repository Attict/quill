part of quill;

class Scene extends Quill {
  bool initialized = false;

  set origin(Origin origin) => getComponent<PositionComponent>().origin = origin;
  
  get position => getComponent<PositionComponent>();

  void initWithBackground(Color color, {Texture texture}) {
    if (!initialized) {
      addComponent<ColorComponent>(new ColorComponent())..setColor(color);
      addComponent<PositionComponent>(new PositionComponent())
        ..setPosition(0.0, 0.0);
      addComponent<SizeComponent>(new SizeComponent())
        ..setSize(Context.width, Context.height);
      initialized = true;
    }
  }

  void setSize(double width, double height) {
  }

  void setPosition(double x, double y) {
    PositionComponent position = this.position;
    if (position == null) {
      position = addComponent<PositionComponent>(new PositionComponent());
    }
    position.setPosition(x, y);
  }

  void translate(double x, double y) {
    CameraComponent camera = getComponent<CameraComponent>();
    if (camera == null) {
      camera = addComponent<CameraComponent>(new CameraComponent());
    }
    camera.translate(x, y);
  }


}
