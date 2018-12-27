part of quill;

/// The context object should be used to control
/// the canvas.

class Context {
  static double width;
  static double height;

  /// Gives control over the canvas object, to render.
  final ui.Canvas canvas;
  Context(this.canvas);

  /// Draw a rectangle that displays:
  ///   a color, a texture or a custom paint object.
  void drawRect(Rect rect, {Color color, Texture texture}) {
    if (color != null) {
      canvas.drawRect(rect.toDart(), new ui.Paint()..color = color.toDart());
    } else if (texture != null) {}
  }
}
