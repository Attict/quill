part of quill;

class Rect {
  double x;
  double y;
  double w;
  double h;
  Rect(this.x, this.y, this.w, this.h);

  ui.Rect toDart() {
    return new ui.Rect.fromLTWH(x, y, w, h);
  }
}