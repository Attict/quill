part of quill;

class Origin {
  static const int custom = 0;
  static const int top_left = 1;
  static const int top_center = 2;
  static const int top_right = 3;
  static const int center_left = 4;
  static const int center = 5;
  static const int center_right = 6;
  static const int bottom_left = 7;
  static const int bottom_center = 8;
  static const int bottom_right = 9;

  final int _value;
  Point _offset;
  Size _objectSize;

  Origin([this._value = 5, this._offset]);

  Point get offset {
    switch (_value) {
      case custom:
        if (_offset == null) {
          _offset = new Point(0.0, 0.0);
        }
        return _offset;
      case top_left:
        double x = 0.0;
        double y = 0.0;
        return new Point(x, y);
      case top_center:
        double x = 0.0;
        double y = 0.0;
        return new Point(x, y);
      case top_right:
        double x = 0.0;
        double y = 0.0;
        return new Point(x, y);
      case center_left:
        double x = 0.0;
        double y = 0.0;
        return new Point(x, y);
      case center:
        double x = 0.0;
        double y = 0.0;
        return new Point(x, y);
      case center_right:
        double x = 0.0;
        double y = 0.0;
        return new Point(x, y);
      case bottom_left:
        double x = 0.0;
        double y = 0.0;
        return new Point(x, y);
      case bottom_center:
        double x = 0.0;
        double y = 0.0;
        return new Point(x, y);
      case bottom_right:
        double x = 0.0;
        double y = 0.0;
        return new Point(x, y);
      default:
        return new Point(0.0, 0.0);
    }
  }
}
