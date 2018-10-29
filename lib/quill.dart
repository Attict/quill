library quill;

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/services.dart';

part './core/animation.dart';
part './core/component.dart';
part './core/context.dart';
part './core/event.dart';
part './core/feather.dart';
part './core/quill.dart';
part './core/texture.dart';
part './core/time.dart';
part './core/timer.dart';

part './components/action_component.dart';
part './components/animation_component.dart';
part './components/color_component.dart';
part './components/input_component.dart';
part './components/manager_component.dart';
part './components/position_component.dart';
part './components/size_component.dart';
part './components/text_component.dart';
part './components/texture_component.dart';
part './components/timer_component.dart';

part './quills/label.dart';
part './quills/scene.dart';
part './quills/sprite.dart';

class QuillEngine {
  static const MethodChannel _channel = const MethodChannel('quill');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// The
  final Feather _application;
  Duration _lastUpdate;
  double fps;
  QuillEngine(this._application, {this.fps});

  /// This is where the user will start their application.
  Future<Null> start() async {
    await initialize();

    /// TODO: This should not happen here
    _application.load();

    /// Begin handling input, and running
    window.onPointerDataPacket = this.handleInput;
    window.onBeginFrame = this.run;
    window.scheduleFrame();
  }

  /// This initializes the QuillEngine
  Future<Null> initialize() async {
    /// Prepare the Context
    //final Size screenSize = window.physicalSize / window.devicePixelRatio;
    final Size screenSize = await new Future<Size>(() {
      if (window.physicalSize.isEmpty) {
        var completer = new Completer<Size>();
        window.onMetricsChanged = () {
          if (!window.physicalSize.isEmpty) {
            if (!completer.isCompleted)
              completer.complete(window.physicalSize / window.devicePixelRatio);
          }
        };
        return completer.future;
      }
      return window.physicalSize / window.devicePixelRatio;
    });
    Context.width = screenSize.width;
    Context.height = screenSize.height;
    _application.init();
  }

  void run(Duration timeStamp) {
    /// LOAD:
    /// Handle Load

    /// UNLOAD:
    /// Handle Unload

    /// UPDATE:
    /// Prepare the [update] loop, then start updating.
    if (_lastUpdate == null) {
      _lastUpdate = timeStamp;
    }
    Duration delta = _lastUpdate - timeStamp;
    Time time = new Time(delta);
    if (fps != null && time.elapsedSeconds < 1.0 / fps) {
      window.scheduleFrame();
      return;
    }
    _lastUpdate = timeStamp;
    _application.update(time);

    /// RENDER:
    /// This is where our [render] loop happens, by building
    /// the canvas, and context.  By efault, we center the canvas
    /// and all objects to the center.
    ///
    /// Optionally the user can replace change the canvas translation
    /// by calling [context.translate(x, y)].
    final Rect paintBounds =
        Offset.zero & (window.physicalSize / window.devicePixelRatio);
    final PictureRecorder recorder = new PictureRecorder();
    final Canvas canvas = new Canvas(recorder, paintBounds);
    final Context context = new Context(canvas)
      ..translate(Context.width / 2, Context.height / 2);
    _application.render(context);

    /// FINALLY:
    /// Render the final picture to the screen, then
    /// request the following frame to be scheduled.
    final Picture picture = recorder.endRecording();
    final Float64List deviceTransform = new Float64List(16)
      ..[0] = window.devicePixelRatio
      ..[5] = window.devicePixelRatio
      ..[10] = 1.0
      ..[15] = 1.0;
    final SceneBuilder builder = new SceneBuilder()
      ..pushTransform(deviceTransform)
      ..addPicture(Offset.zero, picture)
      ..pop();
    window.render(builder.build());
    window.scheduleFrame();
  }

  void handleInput(PointerDataPacket packet) {
    double scaleX = Context.width / window.physicalSize.width;
    double scaleY = Context.height / window.physicalSize.height;
    for (PointerData datum in packet.data) {
      double x = scaleX * datum.physicalX - Context.width / 2;
      double y = scaleY * datum.physicalY - Context.height / 2;
      Event event;
      if (datum.change == PointerChange.up) {
        event = new Event(Event.touchup, new Point(x, y));
      } else if (datum.change == PointerChange.down) {
        event = new Event(Event.touchdown, new Point(x, y));
      }
      if (event != null) {
        _application.input(event);
      }
    }
  }
}

enum Origin {
  top_left,
  top_center,
  top_right,
  center_left,
  center,
  center_right,
  bottom_left,
  bottom_center,
  bottom_right,
}
