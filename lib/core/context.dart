part of quill;

/// The context object should be used to control
/// the canvas.

class Context {
  static double width;
  static double height;
  static Point translate;
  static Point scale = const Point(1.0, 1.0);
  static double rotation;
  static Origin _origin;
  static get origin => _origin;
  static set origin(Origin origin) {
    _origin = origin;
  }

  /// Gives control over the canvas object, to render.
  final Canvas canvas;
  Context(this.canvas);

  /// Draw a rectangle that displays:
  ///   a color, a texture or a custom paint object.
  void drawRect(double x, double y, double w, double h,
      {Color color, Texture texture, Paint paint}) {
    if (color != null) {
      canvas.drawRect(
          new Rect.fromLTWH(x, y, w, h), new Paint()..color = color);
    } else if (texture != null) {}
  }
}
