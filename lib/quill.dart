library quill;

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/services.dart';

part './core/component.dart';
part './core/context.dart';
part './core/event.dart';
part './core/feather.dart';
part './core/quill.dart';
part './core/texture.dart';
part './core/time.dart';

part './components/color_component.dart';
part './components/position_component.dart';
part './components/size_component.dart';

part './quills/sprite.dart';

class QuillEngine {
  static const MethodChannel _channel =
      const MethodChannel('quill');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// The 
  final Feather _application;
  Duration _lastUpdate;
  QuillEngine(this._application);

  /// This is where the user will start their application.
  void start() {
    initialize();
  }

  /// This initializes the QuillEngine
  void initialize() {
    /// Prepare the Context
    final Size screenSize = window.physicalSize / window.devicePixelRatio;
    Context.width = screenSize.width;
    Context.height = screenSize.height;
    _application.init();

    /// Begin handling input, and running
    window.onPointerDataPacket = this.handleInput; 
    window.onBeginFrame = this.run;
    window.scheduleFrame();
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
    _lastUpdate = timeStamp;
    Time time = new Time(delta);
    _application.update(time);

    /// RENDER:
    /// This is where our [render] loop happens, by building
    /// the canvas, and context.  By efault, we center the canvas
    /// and all objects to the center.  
    ///
    /// Optionally the user can replace change the canvas translation
    /// by calling [context.translate(x, y)].
    final Rect paintBounds = Offset.zero & 
        (window.physicalSize / window.devicePixelRatio);
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
  }
}
