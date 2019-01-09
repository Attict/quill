part of quill;

class ColorComponent extends Component {
  Color color;

  @override
  void init() {
    super.init();

    color = new Color(0xFFFF0000);

    if (!quill.hasComponent<TransformComponent>()) {
      quill.addComponent<TransformComponent>(new TransformComponent());
    }
    
    if (!quill.hasComponent<SizeComponent>()) {
      quill.addComponent<SizeComponent>(new SizeComponent());
    }
  }

  @override
  void render(Context context) {
    super.render(context);
    final transform = quill.getComponent<TransformComponent>();
    final position = transform.position;
    final size = quill.getComponent<SizeComponent>();

    final destination = new Rect(position.x, position.y, size.width, size.height);
    context.drawRect(destination, color: color);
  }
}
