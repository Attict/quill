part of quill;

class Texture {
  /// Make sure the file name is also included inside of
  /// the [pubspec.yaml] file.
  String filename;

  /// The Image itself
  Image image;

  /// Used to make sure the image is only loaded once,
  /// and that a single texture's load is only called once,
  /// but completed at the same time.
  Completer<Image> completer;

  /// Create the texture by filename
  Texture(this.filename);

  /// Load the texture during [load]
  Future<Null> load() async {
    if (image == null && completer == null) {
      completer = new Completer();
      ByteData data = await rootBundle.load('assets/images/$filename');
      Uint8List bytes = new Uint8List.view(data.buffer);
      if (!completer.isCompleted) {
        decodeImageFromList(bytes, (image) => completer.complete(image));
      }
    }
    image = await completer.future;
  }

  Future<Null> unload() async {
    image.dispose();
    image = null;
  }
}
