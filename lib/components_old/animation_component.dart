part of quill;

class AnimationComponent extends Component {
  Map<String, Animation> animations = new Map<String, Animation>();
  String current;

  @override
  void load() {
    super.load();
    for (Animation animation in animations.values) {
      animation.load();
    }
  }

  @override
  void unload() {
    super.unload();
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
      PositionComponent position = quill.getComponent<PositionComponent>();
      SizeComponent size = quill.getComponent<SizeComponent>();
      Rect destination = new Rect.fromLTWH(
          position.drawAt.x, position.drawAt.y, size.width, size.height);
      Paint paint = new Paint()..color = const Color(0xFFFFFFFF);
      context.canvas.drawImageRect(animations[current].texture.image,
          animations[current].currentFrame(), destination, paint);
    }
  }

  void setAnimations(Map<String, Animation> animations) {
    this.animations = animations;
    setAnimation(animations.keys.first);
  }

  /// Add animations by name to our mapped list of animations.
  /// If the animations map is not yet allocated, create and allocate it.
  /// The first animation to be set, is automatically set to current animation.
  void addAnimation(String name, Animation animation) {
    /// Assert that this animation does not already exist
    if (animations[name] != null) {
      print('QUILL: Animation $name already exists!');
      return;
    }

    /// If current is null, set it to this animation
    if (current == null) {
      current = name;
    }

    /// Finally, add the animation by name
    animations[name] = animation;
  }

  /// Remove the animation from the map
  void removeAnimation(String name) {
    animations.remove(name);
  }

  /// Set the current animation by name
  void setAnimation(String name) {
    if (animations[name] != null) {
      current = name;
    }
  }

  /// TODO: Allow adding frames to an animation
  void addFrame(String animationName, AnimationFrame frame) {}
}
