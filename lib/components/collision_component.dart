part of quill;

class CollisionComponent extends Component {
  bool isColliding(Quill quill) {
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

    quillPoints[0] = new Point(quillPosition.drawAt.x, 
        quillPosition.drawAt.y);
    quillPoints[1] = new Point(quillPosition.drawAt.x + quillSize.width, 
        quillPosition.drawAt.y);
    quillPoints[2] = new Point(quillPosition.drawAt.x, 
        quillPosition.drawAt.y + quillSize.height);
    quillPoints[3] = new Point(quillPosition.drawAt.x + quillSize.width, 
        quillPosition.drawAt.y + quillSize.height);

    double left = position.drawAt.x;
    double top = position.drawAt.y;
    double right = position.drawAt.x + size.width;
    double bottom = position.drawAt.y + size.height;

    for (final point in quillPoints) {
      if (left <= point.x && point.x <= right &&
          top <= point.y && point.y <= bottom) {
        return true;
      }
    }
    return false;
  }
}
