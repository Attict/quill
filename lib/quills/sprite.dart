part of quill;

class Sprite extends Quill {
  void initWithColor(Color color, Point position, Size size) {
    addComponent<ColorComponent>(new ColorComponent(color));
    addComponent<PositionComponent>(new PositionComponent(position.x, position.y));
    addComponent<SizeComponent>(new SizeComponent(size.width, size.height));
  }
}
