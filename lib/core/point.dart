part of quill;

class Point {
  double x;
  double y;
  Point(this.x, this.y);

  math.Point toDart() {
    return new math.Point(x, y); 
  }
}