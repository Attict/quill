import 'package:quill/quill.dart';

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
  @override
  void init() {
    super.init();
    setTranslate(0.0, 0.0);
    setScale(1.0, -1.0);

    addSprite('sprite', new Sprite())
      ..setSize(50.0, 50.0)
      ..setPosition(50.0, 50.0)
      ..setColor(new Color(0xFF00FF00))
      ..setOrigin(Origin.bottom_right);
  }

  @override
  void update(Time time) {
    super.update(time);
    
    //Sprite sprite = getSprite('sprite');
    //sprite.x += time.elapsedSeconds * 50;
    //if (sprite.x >= Context.width) {
    //  sprite.x = 0 - sprite.width;
    //}
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
