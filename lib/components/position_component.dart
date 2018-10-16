part of quill;

class PositionComponent extends Component {
  double _x, _y;
  Point _offset;
  Origin _origin = Origin.center;

  double get x => _x;
  set x(double x) => _x = x;
  double get y => _y;
  set y(double y) => _y = y;
  Point get drawAt => new Point(x - offset.x, y - offset.y);
  Point get offset => _offset;
  set offset(Point offset) => _offset = offset;
  Origin get origin => _origin;
  set origin(Origin origin) => _origin = origin;

  void setPosition(double x, double y) {
    _x = x;
    _y = y;
  }

  @override
  void init() {
    super.init();
    if (offset == null) {
      SizeComponent size = quill.getComponent<SizeComponent>();
      if (size != null) {
        double offsetX, offsetY;
        switch (origin) {
          case Origin.top_center:
            offsetX = 0.5 * size.width;
            offsetY = 0.0;
            break;
          case Origin.top_right:
            offsetX = size.width;
            offsetY = 0.0;
            break;
          case Origin.center_left:
            offsetX = 0.0;
            offsetY = 0.5 * size.height;
            break;
          case Origin.center:
            offsetX = 0.5 * size.width;
            offsetY = 0.5 * size.height;
            break;
          case Origin.center_right:
            offsetX = size.width;
            offsetY = 0.5 * size.height;
            break;
          case Origin.bottom_left:
            offsetX = 0.0;
            offsetY = size.height;
            break;
          case Origin.bottom_center:
            offsetX = 0.5 * size.width;
            offsetY = size.height;
            break;
          case Origin.bottom_right:
            offsetX = size.width;
            offsetY = size.height;
            break;
          default:
            offsetX = 0.0;
            offsetY = 0.0;
        }
        _offset = new Point(offsetX, offsetY);
      }
    }
  } // init
}

