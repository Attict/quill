part of quill;

class TextureComponent extends Component {
  Texture texture;
  Rect source;

  @override
  void init() {
    super.init();

    if (!quill.hasComponent<TransformComponent>()) {
      quill.addComponent<TransformComponent>(new TransformComponent());
    }

    if (!quill.hasComponent<SizeComponent>()) {
      quill.addComponent<SizeComponent>(new SizeComponent());
    }
  }

  @override
  void load() {
    super.load();
    texture.load();
  }

  @override
  void unload() {
    super.unload();
    texture.unload();
  }

  @override
  void render(Context context) {
    super.render(context);
    final transform = quill.getComponent<TransformComponent>();
    final position = transform.position;
    final size = quill.getComponent<SizeComponent>();

    final destination = new Rect(position.x, position.y, size.width, size.height);
    context.drawRect(destination, texture: texture, source: source);
    // context.drawRect(destination, color: new Color(0xFF0000FF));
  }

  void setTexture(Texture texture) {
    this.texture = texture;
  }

  void setSource(Rect source) {
    this.source = source;
  }
}