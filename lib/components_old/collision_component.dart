part of quill;

class CollisionComponent extends Component {
  double constraintLeft = 0.0;
  double constraintTop = 0.0;
  double constraintRight = 1.0; 
  double constraintBottom = 1.0;

  void setRelativeConstraints({double left = 0.0, double top = 0.0, 
      double right = 1.0, double bottom = 1.0}) {
    this.constraintLeft = left;
    this.constraintTop = top;
    this.constraintRight = right;
    this.constraintBottom = bottom;
  }

  bool isColliding(Quill quill, {double relativeLeft = 0.0, 
        double relativeTop = 0.0, double relativeRight = 1.0, 
        double relativeBottom = 1.0}) {
    PositionComponent position = this.quill.getComponent<PositionComponent>();
    SizeComponent size = this.quill.getComponent<SizeComponent>();
    PositionComponent quillPosition = quill.getComponent<PositionComponent>();
    SizeComponent quillSize = quill.getComponent<SizeComponent>();
    if (position == null || size == null || 
        quillPosition == null || quillSize == null) {
      return false; 
    }
     
    List<Point> points = new List<Point>(4);
    List<Point> quillPoints = new List<Point>(4);

    points[0] = new Point(position.drawAt.x, position.drawAt.y);
    points[1] = new Point(position.drawAt.x + size.width, position.drawAt.y);
    points[2] = new Point(position.drawAt.x, position.drawAt.y + size.height);
    points[3] = new Point(position.drawAt.x + size.width, 
        position.drawAt.y + size.height);



    quillPoints[0] = new Point(
        quillPosition.drawAt.x + relativeLeft * quillSize.width, 
        quillPosition.drawAt.y + relativeTop * quillSize.height);
    quillPoints[1] = new Point(
        quillPosition.drawAt.x + relativeRight * quillSize.width, 
        quillPosition.drawAt.y + relativeTop * quillSize.height);
    quillPoints[2] = new Point(
        quillPosition.drawAt.x + relativeLeft * quillSize.width, 
        quillPosition.drawAt.y + relativeBottom * quillSize.height);
    quillPoints[3] = new Point(
        quillPosition.drawAt.x + relativeRight * quillSize.width, 
        quillPosition.drawAt.y + relativeBottom * quillSize.height);

    double left = position.drawAt.x + size.width * constraintLeft;
    double top = position.drawAt.y + size.height * constraintTop;
    double right = position.drawAt.x + size.width * constraintRight;
    double bottom = position.drawAt.y + size.height * constraintBottom;

    for (final point in quillPoints) {
      if (left <= point.x && point.x <= right &&
          top <= point.y && point.y <= bottom) {
        return true;
      }
    }
    return false;
  }
}
