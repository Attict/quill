part of quill;

class CameraComponent extends Component {
  Origin origin;
  final Transform transform = new Transform();

  /// Initialize each component with the default settings,
  /// initializing any components that it depends on.
  @override
  void init() {
    super.init();

    if (origin == null) {
      origin = new Origin(Origin.center);
    }

    if (transform.position == null) {
      transform.position = new Point(0.0, 0.0);
    }

    if (transform.rotation == null) {
      transform.rotation = 0.0;
    }

    if (transform.scale == null) {
      transform.scale = new Point(1.0, 1.0);
    }

    if (!quill.hasComponent<SizeComponent>()) {
      final Size size = new Size(Context.width, Context.height);
      quill.addComponent<SizeComponent>(new SizeComponent())
        ..setSize(size);
    }
  }

  @override
  void render(Context context) {
    super.render(context); 

    double positionScaleX = (transform.scale.x < 0) 
        ? getSize().width * -transform.scale.x : 0.0;
    double positionScaleY = (transform.scale.y < 0) 
        ? getSize().height * -transform.scale.y : 0.0;

    context.canvas.translate(transform.position.x + positionScaleX, 
        transform.position.y + positionScaleY);
    context.canvas.rotate(
        transform.rotation);
    context.canvas.scale(
        transform.scale.x, transform.scale.y);
  }

  void setOrigin(Origin origin) {
    this.origin = origin;
  }

  void setTranslate(double x, double y) {
    transform.position = new Point(x, y);
  }

  void setRotation(double rotation) {
    transform.rotation = rotation;
  }

  void setScale(double x, double y) {
    transform.scale = new Point(x, y);
  }

  Size getSize() {
    return quill.getComponent<SizeComponent>().getSize();
  }

  Point getTranslate() {
    return transform.position;
  }

}
