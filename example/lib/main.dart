import 'package:quill/quill.dart';
import 'dart:math';


/// Main
/// 
/// 
void main() {
  new QuillEngine(new Application())
    ..start();
}

/// Application
/// 
/// 
class Application extends Feather {
  @override
  void init() {
    super.init();
    addFeather('game_scene', new GameScene());
  }
}

/// Game Scene
/// 
/// 
class GameScene extends Scene {
  final User user = new User();
  final List<Platform> platforms = new List<Platform>(10);

  @override
  void init() {
    super.init();
    setTranslate(0.0, 0.0);
    setScale(1.0, -1.0);

    for (int i = 0; i < 10; i++) {
      platforms[i] = new Platform(i);
      addSprite('platform-$i', platforms[i]);
    }
    addSprite('user', user);
  }

  @override
  void update(Time time) {
    super.update(time);
    if (user.state == User.falling) {
      for (final platform in platforms) {
        if (platform.canLand(user)) {
          user.setPlatform(platform);
          setTranslate(0, platform.y - 200);
        } 
      }
    }

    if (user.state == User.standing && user.platform == null) {
      setTranslate(0, 0);
    }
  }

  void updateCamera() {

  }
}

class User extends Sprite {
  /// The user states
  static int standing = 0;
  static int jumping = 1;
  static int falling = 2;
  static int sleeping = 10;

  int state;
  double jumpTo;
  double offset;
  Platform platform;

  @override
  void init() {
    super.init();
    setSize(50.0, 100.0); 
    setPosition(Context.width / 2 - width / 2, 0);
    setColor(new Color(0xFFFF0000));
    state = standing;
    offset = 0;
  }

  @override
  void input(Event event) {
    super.input(event);
    if (state == standing) {
      jumpTo = y + 200.0;
      state = jumping;
      offset = 0;
      platform = null;
    }
  }

  @override
  void update(Time time) {
    super.update(time);
    if (state == jumping) {
      y += 300.0 * time.elapsedSeconds;
      if (y > jumpTo) {
        state = falling;
      }
    } else if (state == falling) {
      y -= 300.0 * time.elapsedSeconds;
      if (y < 0) {
        y = 0;
        state = standing;
      }
    } else {
      // if platform not null
      if (platform != null) {
        x = platform.x + offset;
      }
    }
  }

  void setPlatform(Platform platform) {
    this.platform = platform;
    state = standing;
    y = platform.y + platform.height;
    offset = x - platform.x;
  }
}

class Platform extends Sprite {
  final double minimumSpeed = 100.0;
  final double maximumSpeed = 380.0;

  final int index;
  int direction;
  double speed;

  Platform(this.index);

  @override
  void init() {
    super.init();

    setSize(100.0, 10.0);

    final Random random = new Random(index);
    direction = (random.nextBool()) ? 1 : -1;
    final double x = random.nextDouble() * (Context.width - width);
    speed = random.nextDouble() * maximumSpeed;
    speed = (speed < minimumSpeed) ? minimumSpeed : speed;

    setPosition(x, (index + 1) * 150.0);
    setColor(new Color(0xFF00FF00)); 
  }

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

  bool canLand(User user) {
    final double userLeft = user.x + user.width * 0.25;
    final double userRight = user.x + user.width * 0.75;
    final double userY = user.y;
    if (y < userY && userY < y + height) {
      if (x < userLeft && userRight < x + width) {
        return true;
      }
    }
    return false;
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
