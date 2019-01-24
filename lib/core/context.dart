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
  void drawRect(Rect rect, {Color color, Texture texture, Rect source}) {
    if (color != null) {
      canvas.drawRect(rect.toDart(), new ui.Paint()..color = color.toDart());
    } else if (texture != null) {
      final paint = new ui.Paint()..color = new ui.Color(0xFFFFFFFF);
      final sourceRect = (source == null) ? null : source.toDart();
      canvas.drawImageRect(texture.image, sourceRect, rect.toDart(), paint);
      // canvas.drawImageRect(texture.image, new ui.Rect.fromLTWH(0, 0, 200, 10), new ui.Rect.fromLTWH(10, 10, 200, 10), paint);
    }
  }
}
