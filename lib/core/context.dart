part of quill;

/// The context object should be used to control
/// the canvas.

class Context {
  static double width;
  static double height;
  static Point translate;
  static Point scale;
  static double rotation;

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
