part of quill;

class Sprite extends Quill {
  TransformComponent _transform;
  SizeComponent _size;

  Point get position => _transform.position;
  double get rotation => _transform.rotation;
  Point get scale => _transform.scale;
  Size get size => _size.getSize();

  @override
  void init() {
    super.init();
    _transform = addComponent<TransformComponent>(new TransformComponent());
    _size = addComponent<SizeComponent>(new SizeComponent());
  }

  void setColor(Color color) {
    ColorComponent colorComponent = getComponent<ColorComponent>();
    if (colorComponent == null) {
      colorComponent = addComponent<ColorComponent>(new ColorComponent());
    }
    colorComponent.color = color;
  }

  void setSize(double width, double height) {
    _size.width = width;
    _size.height = height;
  }

  void setPosition(double x, double y) {
    _transform.setPosition(x, y);
  }
}