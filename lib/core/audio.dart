part of quill;

class Audio {
  static const int unloaded = 0;
  static const int loaded = 1;
  static const int loading = 2;

  final String filename;
  MethodChannel _channel;
  int state;

  int repeat;
  double volume;
  double rate;

  Audio(this.filename, {this.repeat = 0, 
      this.volume = 0.0, this.rate = 0.0});

  Future<Null> dispose() async {}

  Future<Null> load() async {
    String basepath = await QuillEngine.basePath;
    basepath = '$basepath/flutter_assets/assets/audio';
    final String filepath = '$basepath/$filename';
    await QuillEngine.channel.invokeMethod('addAudio',
        <dynamic, dynamic> {'filename': filename, 'filepath': filepath,
        'repeat': repeat, 'volume': volume, 'rate': rate});
    _channel = new MethodChannel('quill/audio/$filename');
    state = loaded;
  }

  Future<Null> unload() async {
  }

  //
  Future<Null> play() async {
    await _channel.invokeMethod('play');
  }
  
  Future<Null> stop() async {}

  Future<Null> pause() async {}
}
