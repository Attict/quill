part of quill;

class PositionComponent extends Component {
  double _x, _y;
  Point _offset = const Point(0.0, 0.0);
  Origin _origin = Origin.center;

  double get x => _x;
  set x(double x) => _x = x;
  double get y => _y;
  set y(double y) => _y = y;
  Point get drawAt => new Point(x - offset.x, y - offset.y);
  Point get offset => _offset;
  set offset(Point offset) => _offset = offset;
  Origin get origin => _origin;
  set origin(Origin origin) {
    _origin = origin;
    if (quill.hasComponent<SizeComponent>()) {
      SizeComponent size = quill.getComponent<SizeComponent>();
      updateOffset(size.width, size.height);
    }
  }

  void setPosition(double x, double y) {
    _x = x;
    _y = y;
  }

  void updateOffset(double width, double height) {
    double offsetX, offsetY;
    switch (origin) {
      case Origin.top_center:
        offsetX = 0.5 * width;
        offsetY = 0.0;
        break;
      case Origin.top_right:
        offsetX = width;
        offsetY = 0.0;
        break;
      case Origin.center_left:
        offsetX = 0.0;
        offsetY = 0.5 * height;
        break;
      case Origin.center:
        offsetX = 0.5 * width;
        offsetY = 0.5 * height;
        break;
      case Origin.center_right:
        offsetX = width;
        offsetY = 0.5 * height;
        break;
      case Origin.bottom_left:
        offsetX = 0.0;
        offsetY = height;
        break;
      case Origin.bottom_center:
        offsetX = 0.5 * width;
        offsetY = height;
        break;
      case Origin.bottom_right:
        offsetX = width;
        offsetY = height;
        break;
      default:
        offsetX = 0.0;
        offsetY = 0.0;
    }
    _offset = new Point(offsetX, offsetY);
  }
}
