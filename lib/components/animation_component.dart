part of quill;

class AnimationComponent extends Component {
  Map<String, Animation> animations = new Map<String, Animation>();
  String current;

  @override
  void load() {
    super.load();
    for (final animation in animations.values) {
      animation.load();
    }
  }

  @override
  void update(Time time) {
    super.update(time);
    if (animations[current] != null) {
      animations[current].update(time);
    }
  }

  @override
  void render(Context context) {
    super.render(context);
    if (animations[current] != null &&
        animations[current].texture.image != null) {
      final transform = quill.getComponent<TransformComponent>();
      final position = transform.position;
      final size = quill.getComponent<SizeComponent>();
      final destination = new Rect(position.x, position.y, size.width, size.height);
      final texture = animations[current].texture;
      final frame = animations[current].currentFrame();
      context.drawRect(destination, texture: texture, source: frame);
    }
  }

  void setAnimation(String name) {
    if (animations[name] != null) {
      current = name;
    }
  }

  void setAnimations(Map<String, Animation> animations) {
    this.animations = animations;
    setAnimation(animations.keys.first);
  }

  void addAnimation(String name, Animation animation) {
    if (animations[name] == null) {
      animations[name] = animation;

      if (current == null) {
        current = name;
      }
    }
  }

  void removeAnimation(String name) {
    animations.remove(name);
  }

}
