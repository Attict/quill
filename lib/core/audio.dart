part of quill;

class Audio {
  static const int unloaded = 0;
  static const int loaded = 1;
  static const int loading = 2;

  final String filename;
  MethodChannel _channel;
  int state;

  Audio(this.filename);

  Future<Null> dispose() async {}

  Future<Null> load() async {
    String basepath = await QuillEngine.basePath;
    basepath = '$basepath/flutter_assets/assets/audio';
    final String filepath = '$basepath/$filename';
    await QuillEngine.channel.invokeMethod('addAudio',
        <dynamic, dynamic> {'filename': filename, 
        'filepath': filepath});
    _channel = new MethodChannel('quill/audio/$filename');
    state = loaded;
  }

  Future<Null> unload() async {
     
  }

  Future<Null> play({int repeat = 0}) async {
    _channel.invokeMethod('play',
        <dynamic, dynamic> {'repeat': repeat});
  }
  
  Future<Null> stop() async {}

  Future<Null> pause() async {}
}
