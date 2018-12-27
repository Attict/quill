part of quill;

class SizeComponent extends Component {
  Size _size;

  double get width => _size.width;
  double get height => _size.height;

  set width(double width) => _size.width = width;
  set height(double height) => _size.height = height;

  @override
  void init() {
    super.init();
    _size = new Size(50.0, 50.0);
  }

  Size getSize() {
    return _size;
  }

  void setSize(Size size) {
    _size = size;
  }
}