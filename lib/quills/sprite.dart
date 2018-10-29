part of quill;

class Sprite extends Quill {
  bool initialized = false;
  PositionComponent get position => getComponent<PositionComponent>();
  SizeComponent get size => getComponent<SizeComponent>();
  double get halfWidth => size.width / 2;
  double get halfHeight => size.height / 2;
  double get left => position.x - size.width / 2;
  double get top => position.y - size.height / 2;
  double get right => position.x + size.width / 2;
  double get bottom => position.y + size.height / 2;
  Point get bottomLeft => new Point(0.0, 0.0);
  Point get bottomRight => new Point(0.0, 0.0);
  Point get topLeft => new Point(0.0, 0.0);
  Point get topRight => new Point(0.0, 0.0);

  set color(Color color) => getComponent<ColorComponent>().color = color;
  set origin(Origin origin) {
    if (!hasComponent<PositionComponent>()) {
      addComponent<PositionComponent>(new PositionComponent());
    }
    getComponent<PositionComponent>().origin = origin;
  }

  void setPosition(double x, double y) {
    if (!hasComponent<PositionComponent>()) {
      addComponent<PositionComponent>(new PositionComponent());
    }
    position.setPosition(x, y);
  }

  void setSize(double width, double height) {
    if (!hasComponent<SizeComponent>()) {
      addComponent<SizeComponent>(new SizeComponent());
    }
    size.setSize(width, height);
  }

  void setSource(double x, double y, double width, double height) {
    getComponent<TextureComponent>().setSource(x, y, width, height);
  }

  void initWithColor(Color color) {
    if (!initialized) {
      addComponent<ColorComponent>(new ColorComponent())..setColor(color);
      initialized = true;
    }
    // TODO: else throw new exception
  }

  void initWithTexture(Texture texture, {Rect source}) {
    if (!initialized) {
      addComponent<TextureComponent>(new TextureComponent())
        ..setTexture(texture, source: source);
      initialized = true;
    }
  }

  void initWithAnimation(Animation animation) {
    if (!initialized) {
      addComponent<AnimationComponent>(new AnimationComponent())
        ..addAnimation('default', animation);
      initialized = true;
    }
  }

  void initWithAnimations(Map<String, Animation> animations) {
    if (!initialized) {
      addComponent<AnimationComponent>(new AnimationComponent())
        ..setAnimations(animations);
      initialized = true;
    }
  }

  void setAnimation(String animationName) {
    if (hasComponent<AnimationComponent>()) {
      getComponent<AnimationComponent>().setAnimation(animationName);
    }
  }
}
