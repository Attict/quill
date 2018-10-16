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

  void initWithColor(Color color, Point position, Size size, {Origin origin}) {
    if (!initialized) {
      addComponent<ColorComponent>(new ColorComponent())
        ..setColor(color);
      addComponent<PositionComponent>(new PositionComponent())
        ..setPosition(position.x, position.y);
      addComponent<SizeComponent>(new SizeComponent())
        ..setSize(size.width, size.height);
      initialized = true;
    }
    // TODO: else throw new exception
  }

  void initWithTexture(Texture texture, Rect source, Point position, Size size, 
      {Origin origin}) {
    if (!initialized) {
      addComponent<TextureComponent>(new TextureComponent())
        ..setTexture(texture, source: source);
      addComponent<PositionComponent>(new PositionComponent())
        ..setPosition(position.x, position.y);
      addComponent<SizeComponent>(new SizeComponent())
        ..setSize(size.width, size.height);
      initialized = true;
    }
  }

  void initWithAnimation(Animation animation, Point position, Size size, 
      {Origin origin}) {
    if (!initialized) {
      addComponent<AnimationComponent>(new AnimationComponent())
        ..addAnimation('default', animation);
      addComponent<PositionComponent>(new PositionComponent())
        ..setPosition(position.x, position.y);
      addComponent<SizeComponent>(new SizeComponent())
        ..setSize(size.width, size.height);
      initialized = true;
    }
  }

  void initWithAnimations(Map<String, Animation> animations, Point position, 
      Size size, {Origin origin}) {
    if (!initialized) {
      addComponent<AnimationComponent>(new AnimationComponent())
        ..setAnimations(animations);
      addComponent<PositionComponent>(new PositionComponent())
        ..setPosition(position.x, position.y);
      addComponent<SizeComponent>(new SizeComponent())
        ..setSize(size.width, size.height);
      initialized = true;
    }
  }

  void setAnimation(String animationName) {
    if (hasComponent<AnimationComponent>()) {
      getComponent<AnimationComponent>().setAnimation(animationName);
    }
  }
}
