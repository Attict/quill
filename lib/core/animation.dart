part of quill;

/// All animation options are set in this enum
/// such as how the animation will act.
/// [Teeter] animation will go from start to end to start
/// [Repeat] will go from start to end, repeating
/// TODO: More options, or refactor
enum AnimationOptions { teeter, repeat }

class Animation {
  /// The texture for the animation
  final Texture texture;

  /// The frames inside of the animation in order
  List<AnimationFrame> frames = new List<AnimationFrame>();

  /// How far into the animation
  double timeIntoAnimation;

  /// Presets options, to be loaded after initialiation
  /// These are used to avoid problems with setting these options
  /// prior to actually being loaded in the [load] method
  Map<String, dynamic> presets;

  bool loaded = false;

  Animation(this.texture);

  void init() {}

  /// If `presets` are set, then generate the frames
  Future<Null> load() async {
    timeIntoAnimation = 0.0;
    await texture.load();
    if (presets != null) {
      int horizontalFrames = (texture.image.width / presets['width']).floor();
      //int verticalFrames = (texture.image.height / presets['height']).floor();
      for (int i = presets['start']; i < presets['end']; i++) {
        double x = (i % horizontalFrames).toDouble();
        double y = (i / horizontalFrames).floor().toDouble();
        addFrame(
            presets['duration'],
            Rect.fromLTWH(x * presets['width'], y * presets['height'],
                presets['width'], presets['height']));
      }

      if (presets['direction'] != null &&
          presets['direction'] == AnimationOptions.teeter) {
        for (int i = presets['end'] - 1; i > presets['start']; i--) {
          double x = (i % horizontalFrames).toDouble();
          double y = (i / horizontalFrames).floor().toDouble();
          addFrame(
              presets['duration'],
              Rect.fromLTWH(x * presets['width'], y * presets['height'],
                  presets['width'], presets['height']));
        }
      }
    }
    loaded = true;
  }

  double totalSeconds() {
    double totalSeconds = 0.0;
    for (AnimationFrame frame in frames) {
      totalSeconds += frame.durationInSeconds;
    }
    return totalSeconds;
  }

  Rect currentFrame() {
    AnimationFrame currentFrame;
    double accumulatedTime = 0.0;

    for (AnimationFrame frame in frames) {
      if (accumulatedTime + frame.durationInSeconds >= timeIntoAnimation) {
        currentFrame = frame;
        break;
      } else {
        accumulatedTime += frame.durationInSeconds;
      }
    }

    if (currentFrame == null) {
      currentFrame = frames.last;
    }

    return currentFrame.frame;
  }

  void addFrame(double durationInSeconds, Rect rect) {
    if (frames == null) {
      frames = new List<AnimationFrame>();
    }
    frames.add(new AnimationFrame(durationInSeconds, rect));
  }

  /// Create the frames from `start` to `end` going across and then down.
  /// This actually presets the information, because the image needs to be loaded
  /// before the frames can be created.
  void createFrames(
      double duration, int start, int end, double width, double height,
      {AnimationOptions direction}) {
    presets = new Map<String, dynamic>();
    presets['duration'] = duration;
    presets['start'] = start;
    presets['end'] = end;
    presets['width'] = width;
    presets['height'] = height;
    if (direction != null) {
      presets['direction'] = direction;
    }
  }

  void update(Time time) {
    if (loaded) {
      double secondsIntoAnimation = timeIntoAnimation + time.elapsedSeconds;
      double remainder = secondsIntoAnimation % totalSeconds();
      timeIntoAnimation = remainder;
    }
  }
}

class AnimationFrame {
  double durationInSeconds;
  Rect frame;

  AnimationFrame(this.durationInSeconds, this.frame);
}
