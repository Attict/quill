part of quill;

/// Things to do with this component:
/// ...add color support
/// ...add blending support

class TextureComponent extends Component {
  Rect _source;
  Texture _texture;

  void setTexture(Texture texture, {Rect source}) {
    if (source == null) {
      /// TODO: Automatically calculate the size
    }
    _texture = texture;
    _source = source;
  }

  @override
  void load() {
    super.load();
    _texture.load();
  }

  @override
  void unload() {
    super.unload();
    _texture.unload();
  }

  @override
  void render(Context context) {
    super.render(context);
    if (_texture.image != null) {
      PositionComponent position = quill.getComponent<PositionComponent>();
      SizeComponent size = quill.getComponent<SizeComponent>();

      /// TODO: Add getComponent to return 0,0

      var destination = new Rect.fromLTWH(
          position.drawAt.x, position.drawAt.y, size.width, size.height);
      var paint = new Paint()..color = const Color(0xFFFFFFFF);

      context.canvas.drawImageRect(_texture.image, _source, destination, paint);
    }
  }

  void setSource(double x, double y, double width, double height) {
    _source = new Rect.fromLTWH(x, y, width, height);
  }
}
