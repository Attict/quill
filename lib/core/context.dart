part of quill;

/// The context object should be used to control
/// the canvas.

class Context {
  static double width;
  static double height;

  /// Gives control over the canvas object, to render.
  final Canvas canvas;
  Context(this.canvas);

  /// Translate the canvas
  void translate(double x, double y) {
    canvas.translate(x, y);
  }

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
