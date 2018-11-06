part of quill;

class CameraComponent extends Component {
  void translate(double x, double y) {
    Context.translate = new Point(x, y);
  }
}
