part of quill;

class CameraComponent extends Component {
  double x = 0.0;
  double y = 0.0;

  @override
  void init() {
    super.init();

    x = Context.translate.x;
    y = Context.translate.y;
  }

  void translate(double x, double y) {
    this.x = x;
    this.y = y;
    // if (Context.scale.y == -1) {
    //   y += Context.height;
    // }
    Context.translate = new Point(x, y);
  }

  void scale(double x, double y) {
    Context.scale = new Point(x, y);
  }
}
