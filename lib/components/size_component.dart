part of quill;

class SizeComponent extends Component {
  Size _size;

  Size getSize() {
    return _size;
  }

  void setSize(Size size) {
    _size = size;
  }

  double getWidth() {
    return _size.width;
  }

  void setWidth(double width) {
    _size.width = width;
  }

  double getHeight() {
    return _size.height;
  }

  void setHeight(double height) {
    _size.height = height;
  }
}