part of quill;

class Scene extends Quill {
  bool initialized = false;
  void initWithBackground(Color color, {Texture texture}) {
    if (!initialized) {
      addComponent<ColorComponent>(new ColorComponent())..setColor(color);
      addComponent<PositionComponent>(new PositionComponent())
        ..setPosition(0.0, 0.0);
      addComponent<SizeComponent>(new SizeComponent())
        ..setSize(Context.width, Context.height);
      initialized = true;
    }
  }

  void setSize(double width, double height) {}
}
