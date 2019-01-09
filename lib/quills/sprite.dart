part of quill;

class Sprite extends Quill {
  TransformComponent _transform;
  SizeComponent _size;

  Point get position => _transform.position;
  double get rotation => _transform.rotation;
  Point get scale => _transform.scale;
  Size get size => _size.getSize();
  Origin get origin => _transform.origin;

  double get width => size.width;
  double get height => size.height;
  double get x => position.x;
  double get y => position.y;
  set x(double x) => _transform.position.x = x;
  set y(double y) => _transform.position.y = y;

  /// TODO:
  /// Left, Right, Bottom, Top
  /// TopLeft, TopCenter, TopRight
  /// CenterLeft, Center, CenterRight
  /// BottomLeft, BottomCenter, BottomRight

  /// Init
  ///
  ///
  @override
  void init() {
    super.init();
    _transform = addComponent<TransformComponent>(new TransformComponent());
    _size = addComponent<SizeComponent>(new SizeComponent());
  }

  /// Set Size
  ///
  ///
  void setSize(double width, double height) {
    _size.width = width;
    _size.height = height;
  }

  /// Set position
  ///
  ///
  void setPosition(double x, double y) {
    _transform.setPosition(x, y);
  }

  void setOrigin(Origin origin) {
    _transform.setOrigin(origin);
  }

  /// Set color
  ///
  ///
  void setColor(Color color) {
    ColorComponent colorComponent = getComponent<ColorComponent>();
    if (colorComponent == null) {
      colorComponent = addComponent<ColorComponent>(new ColorComponent());
    }
    colorComponent.color = color;
  }
}
