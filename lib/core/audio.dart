part of quill;

class Audio {

  final String filename;

  Audio(this.filename);

  Future<Null> load() async {

    final Map<dynamic, dynamic> baseAppPath = 
        await QuillEngine.channel.invokeMethod('baseAppPath');
    final dir = new Directory('${baseAppPath['path']}/flutter_assets/assets/audio');

    final String filePath = '${dir.path}/$filename';

    print(baseAppPath);

    await QuillEngine.channel.invokeMethod('addAudio',
        <dynamic, dynamic> {
          'filename': filePath
        }
    );
  }

}
