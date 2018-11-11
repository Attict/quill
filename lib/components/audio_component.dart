part of quill;

class AudioComponent extends Component {
  Audio _audio;

  void setAudio(Audio audio) {
    _audio = audio;
  }

  @override
  void load() {
    super.load();
    _audio.load();
  }

  @override
  void unload() {
    super.unload();
    _audio.unload();
  }
}
