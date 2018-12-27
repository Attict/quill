part of quill;

class SizeComponent extends Component {
  double _width, _height;
  double get width => _width;
  set width(double width) => _width = width;
  double get height => _height;
  set height(double height) => _height = height;
  void setSize(double width, double height) {
    _width = width;
    _height = height;
    PositionComponent position = quill.getComponent<PositionComponent>();
    if (position != null) {
      position.updateOffset(width, height);
    }
  }
}
