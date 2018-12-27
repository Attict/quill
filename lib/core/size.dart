part of quill;

class Size {
  double width;
  double height;
  Size(this.width, this.height);

  ui.Size toDart() {
    return new ui.Size(width, height);
  }
}