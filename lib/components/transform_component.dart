part of quill;

class TransformComponent extends Component {
  Transform _transform;

  Point get position => _transform.position;
  double get rotation => _transform.rotation;
  Point get scale => _transform.scale;

  @override
  void init() {
    super.init();
    _transform = new Transform()
      ..position = new Point(0.0, 0.0)
      ..rotation = 0.0
      ..scale = new Point(1.0, 1.0);
  }

  void setPosition(double x, double y) {
    _transform.position.x = x;
    _transform.position.y = y;
  }

  void setRotation(double rotation) {
    _transform.rotation = rotation;
  }

  void setScale(double x, double y) {
    _transform.scale.x = x;
    _transform.scale.y = y;
  }
}