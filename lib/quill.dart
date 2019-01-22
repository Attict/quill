library quill;

/// Refactor quill by forming complete quills without 
/// components, then flesh them out into components.

import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

part './core/animation.dart';
part './core/audio.dart';
part './core/color.dart';
part './core/component.dart';
part './core/context.dart';
part './core/event.dart';
part './core/feather.dart';
part './core/origin.dart';
part './core/point.dart';
part './core/quill.dart';
part './core/rect.dart';
part './core/size.dart';
part './core/texture.dart';
part './core/time.dart';
part './core/timer.dart';
part './core/transform.dart';

part './components/camera_component.dart';
part './components/color_component.dart';
part './components/size_component.dart';
part './components/texture_component.dart';
part './components/transform_component.dart';

part './quills/scene.dart';
part './quills/sprite.dart';

/// QuillEngine
///
///
class QuillEngine {
  /// Quill Channel
  ///
  ///
  static const MethodChannel channel = const MethodChannel('quill');

  /// Application path for documents
  ///
  ///
  static String applicationPath;

  /// Application
  ///
  ///
  final Feather application;

  /// Frames per second
  ///
  ///
  final double fps;

  /// Landscape vs portrait
  /// default to portrait
  ///
  final bool landscape;

  /// Last update
  ///
  ///
  Duration _lastUpdate;


  /// Constructor
  ///
  ///
  QuillEngine(this.application, {this.fps: 60.0, this.landscape: false});

  /// Start
  ///
  ///
  Future<Null> start() async {
    await initialize();

    final Map<dynamic, dynamic> result = await channel.invokeMethod('basePath');
    applicationPath = result['path'];

    /// TODO: This should not happen here
    application.load();

    /// Begin handling input, and running the app.
    ui.window.onPointerDataPacket = handleInput;
    ui.window.onBeginFrame = run;
    ui.window.scheduleFrame();
  }

  /// Initialize
  ///
  ///
  Future<Null> initialize() async {
    final ui.Size screenSize = await getScreenSize();
    Context.width = screenSize.width;
    Context.height = screenSize.height;
    application.init();
  }

  /// Run
  ///
  ///
  void run(Duration timeStamp) {
    /// LOAD:
    /// UNLOAD:

    /// UPDATE:
    if (_lastUpdate == null) {
      _lastUpdate = timeStamp;
    }
    Duration delta = _lastUpdate - timeStamp;
    Time time = new Time(delta);
    if (fps != null && time.elapsedSeconds < 1.0 / fps) {
      ui.window.scheduleFrame();
      return;
    }
    _lastUpdate = timeStamp;
    application.update(time);

    /// RENDER:
    final Rect paintBounds = 
        new Rect(0.0, 0.0, Context.width, Context.height);
    final ui.PictureRecorder recorder = new ui.PictureRecorder();
    final ui.Canvas canvas = new ui.Canvas(recorder, paintBounds.toDart());
    final Context context = new Context(canvas);
    application.render(context);

    /// FINALLY:
    final ui.Picture picture = recorder.endRecording();
    final Float64List deviceTransform = new Float64List(16)
      ..[0] = ui.window.devicePixelRatio
      ..[5] = ui.window.devicePixelRatio
      ..[10] = 1.0
      ..[15] = 1.0;
    final ui.SceneBuilder builder = new ui.SceneBuilder()
      ..pushTransform(deviceTransform)
      ..addPicture(ui.Offset.zero, picture)
      ..pop();
    ui.window.render(builder.build());
    ui.window.scheduleFrame();
  }
  
  /// Handle input into the application
  ///
  ///
  void handleInput(ui.PointerDataPacket packet) {
    // double scaleX = Context.width / window.physicalSize.width;
    // double scaleY = Context.height / window.physicalSize.height;
    for (ui.PointerData datum in packet.data) {
      // double x = scaleX * datum.physicalX - Context.width / 2;
      // double y = scaleY * datum.physicalY - Context.height / 2;
      Event event;
      if (datum.change == ui.PointerChange.up) {
        event = new Event(Event.touchup, new Point(0.0, 0.0));
      } else if (datum.change == ui.PointerChange.down) {
        event = new Event(Event.touchdown, new Point(0.0, 0.0));
      }
      if (event != null) {
        application.input(event);
      }
    }
  }

  /// Get screen size
  ///
  ///
  Future<ui.Size> getScreenSize() async {
    final ui.Size screenSize = await new Future<ui.Size>(() {
      if (ui.window.physicalSize.isEmpty) {
        final completer = new Completer<ui.Size>();
        ui.window.onMetricsChanged = () {
          if (!ui.window.physicalSize.isEmpty && !completer.isCompleted) {
            completer.complete(ui.window.physicalSize / ui.window.devicePixelRatio);    
          }
        };
        return completer.future;
      }
      return ui.window.physicalSize / ui.window.devicePixelRatio;
    });
    return screenSize;
  }
}


