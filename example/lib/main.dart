import 'package:quill/quill.dart';
import 'dart:math';


///
/// MAIN
/// 
void main() {
  new QuillEngine(new Application())
    ..start();
}

///
/// APPLICATION
/// 
class Application extends Feather {
  @override
  void init() {
    super.init();
    addFeather('game_scene', new GameScene());
  }
}

///
/// GAME SCENE
/// 
class GameScene extends Scene {
  final User user = new User();
  final List<Platform> platforms = new List<Platform>(10);

  ///
  /// INIT
  /// 
  @override
  void init() {
    super.init();
    setScale(1.0, 1.0);
    setTranslate(0.0, 0.0);
    setColor(new Color(0xFF73b0ff));

    final Texture texture = new Texture('platform.png');
    for (int i = 0; i < 10; i++) {
      final TextureComponent textureComponent = new TextureComponent()
        ..setTexture(texture)
        ..setSource(new Rect(0, 0, 301, 72));
      platforms[i] = new Platform(i)..addComponent<TextureComponent>(textureComponent);
      addSprite('platform-$i', platforms[i]);
    }
    addSprite('user', user);
  }

  ///
  /// UPDATE
  /// 
  @override
  void update(Time time) {
    super.update(time);
    if (user.state == User.falling) {
      for (final platform in platforms) {
        if (platform.canLand(user)) {
          user.setPlatform(platform);
        } 
      }
    }

    shufflePlatforms();
    updateCamera(time);
  }

  ///
  /// UPDATE CAMERA
  /// 
  void updateCamera(Time time) {
    if (user.y + user.height < Context.height - 100) {
      double y = Context.height - (user.y + user.height) - 100;
      setTranslate(0, y);
      getComponent<TransformComponent>().setPosition(0, y * -1);
    }
    //if (user.y + user.height < Context.height - 100) {

    //} else {
    //  int direction = (user.platform != null) ? 1 : -1;
    //  double cameraY = camera.getTranslate().y - (200.0 * direction) * time.elapsedSeconds;
    //  cameraY = (cameraY > 0) ? 0 : cameraY;
    //  setTranslate(0, cameraY);
    //}
  }

  ///
  /// SHUFFLE PLATFORMS
  /// 
  void shufflePlatforms() {
    int start = user.score - 5;
    start = (start < 1) ? 1 : start;
    int end = start + 9;

    for (int i = start; i <= end; i++) {
        var index = (i - 1) % 10;
        if (platforms[index].value != i) {
          platforms[index].reset(i);
        }
    }
  }
}

///
/// [CLASS]
///   User
class User extends Sprite {
  /// 
  /// User States
  /// 
  static int standing = 0;
  static int jumping = 1;
  static int falling = 2;
  static int sleeping = 10;

  ///
  /// PROPERTIES
  /// 
  int score = 0;
  int state;
  double jumpTo;
  double offset;
  Platform platform;

  ///
  /// INIT
  /// 
  @override
  void init() {
    super.init();
    setSize(50.0, 100.0); 
    setPosition(Context.width / 2 - width / 2, Context.height - height);
    setColor(new Color(0xFF0000FF));
    state = standing;
    offset = 0;
  }

  /// 
  /// INPUT
  @override
  void input(Event event) {
    super.input(event);
    if (state == standing) {
      jumpTo = y + height - 200.0;
      state = jumping;
      offset = 0;
      platform = null;
    }
  }

  /// 
  /// UPDATE
  /// 
  @override
  void update(Time time) {
    super.update(time);
    if (state == jumping) {
      y -= 300.0 * time.elapsedSeconds;
      if (y + height < jumpTo) {
        state = falling;
      }
    } else if (state == falling) {
      y += 300.0 * time.elapsedSeconds;
      if (y > Context.height - height) {
        y = Context.height - height;
        state = standing;
      }
    } else {
      // if platform not null
      if (platform != null) {
        x = platform.x + offset;
      }
    }
  }

  ///
  /// SET PLATFORM
  /// 
  /// Sets the current platform that the user
  /// is on.
  void setPlatform(Platform platform) {
    this.platform = platform;
    state = standing;
    y = platform.y - height;
    offset = x - platform.x;
    score = platform.value;
  }
}

///
/// [CLASS]
///   PLATFORM
/// 
class Platform extends Sprite {
  final double minimumSpeed = 100.0;
  final double maximumSpeed = 350.0;
  final double distance = 150.0;

  final int index;
  int direction;
  double speed;
  int value;

  /// 
  /// CONSTRUCTOR
  /// 
  Platform(this.index);

  ///
  /// INIT
  @override
  void init() {
    super.init();

    value = index;

    setSize(120.0, 20.0);

    reset(index + 1);
  }

  ///
  /// UPDATE
  /// 
  @override
  void update(Time time) {
    super.update(time);

    x += direction * (speed * time.elapsedSeconds);
    if (x >= Context.width - width) {
      x = Context.width - width;
      direction *= -1;
    } else if (x <= 0) {
      x = 0;
      direction *= -1;
    }

  }

  /// 
  /// CAN LAND
  /// 
  /// The user can land on this platform.
  bool canLand(User user) {
    final double userLeft = user.x + user.width * 0.1;
    final double userRight = user.x + user.width * 0.9;
    final double userY = user.y + user.height;
    if (y < userY && userY < y + height) {
      if (x < userLeft && userRight < x + width) {
        return true;
      }
    }
    return false;
  }

  /// 
  /// RESET
  ///
  void reset(int value) {
    final Random random = new Random(value);
    direction = (random.nextBool()) ? 1 : -1;
    speed = random.nextDouble() * maximumSpeed;
    speed = (speed < minimumSpeed) ? minimumSpeed : speed;
    final double x = random.nextDouble() * (Context.width - width);
    final double y = Context.height - (value * distance);
    setPosition(x, y);
    this.value = value;
  }
}





// import 'package:quill/quill.dart';
// import 'dart:ui';
// import 'dart:math';

// void main() async {
//   new QuillEngine(new Application())..start();
// }

// class Application extends Feather {
//   @override
//   void init() {
//     super.init();
//     addFeather<GameScene>('gameScene', new GameScene())
//       ..initWithBackground(const Color(0xFF333333));
//   }
// }

// class GameScene extends Scene {
//   Sprite _user;
//   Sprite _quill;
//   int _userDirection = 0;
//   @override
//   void init() {
//     super.init();

//     Audio audio = new Audio('music.aiff');
//     audio.load().then((_) { audio.play(); });

//     Audio audio2 = new Audio('jump.wav', repeat: 5);
//     audio2.load().then((_) { audio2.play(); });

//     _user = new Sprite()
//       ..initWithColor(const Color(0xFFFF0000))
//       ..setPosition(0.0, -284.0)
//       ..setSize(100.0, 100.0);

//     Texture quillTexture = new Texture('quill.png');
//     Rect quillSource = new Rect.fromLTWH(0.0, 0.0, 239.0, 239.0);
//     _quill = new Sprite()
//       ..initWithTexture(quillTexture, source: quillSource)
//       ..setPosition(0.0, 0.0)
//       ..setSize(110.0, 110.0);

//     addFeather('user', _user);
//     addFeather('quill', _quill);

//     _userDirection = 0;
//   }

//   @override
//   void input(Event event) {
//     if (event.isTouchdown) {
//       _userDirection++;
//       if (_userDirection > 3) {
//         _userDirection = 0;
//       }
//     }
//   }

//   @override
//   void update(Time time) {
//     double speed = 100.0 * time.elapsedSeconds;
//     switch (_userDirection) {
//       case 0:
//         _user.position.y += speed;
//         break;
//       case 1:
//         _user.position.x -= speed;
//         break;
//       case 2:
//         _user.position.y -= speed;
//         break;
//       case 3:
//         _user.position.x += speed;
//         break;
//     }

//     if (_user.bottom < Context.height / -2) {
//       _user.position.y = Context.height / 2 + _user.halfHeight;
//     } else if (_user.top > Context.height / 2) {
//       _user.position.y = Context.height / -2 - _user.halfHeight;
//     } else if (_user.right < Context.width / -2) {
//       _user.position.x = Context.width / 2 + _user.halfWidth;
//     } else if (_user.left > Context.width / 2) {
//       _user.position.x = Context.width / -2 - _user.halfWidth;
//     }
//     //} else if (_user.left < Context.width / -2) {
//     //  _user.position.x = Context.width / -2;
//     //} else if (_user.right > Context.width / 2) {
//     //  _user.position.x = Context.width / 2;
//     //}
//   }
// }
