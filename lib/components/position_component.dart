part of quill;

class PositionComponent extends Component {
  double _x, _y;
  Point _offset = const Point(0.0, 0.0);

  double get x => _x - _offset.x;
  set x(double x) => _x = x;
  double get y => _y - _offset.y;
  set y(double y) => _y = y;
  Point get offset => _offset;
  set offset(Point offset) => _offset = offset;

  PositionComponent(this._x, this._y);
}
