part of quill;

class Color {
  final int hex;
  Color(this.hex);

  ui.Color toDart() {
    return new ui.Color(hex);
  }
}