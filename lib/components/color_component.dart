part of quill;

class ColorComponent extends Component {
  Color _color;
  Color get color => _color;
  set color(Color color) => _color = color;
  ColorComponent(this._color);
  @override
  void render(Context context) {
    PositionComponent position = quill.getComponent<PositionComponent>();
    SizeComponent size = quill.getComponent<SizeComponent>();
    double x = (position == null) ? 0.0 : position.x;
    double y = (position == null) ? 0.0 : position.y;
    double w = (size == null) ? 0.0 : size.width;
    double h = (size == null) ? 0.0 : size.height;
    context.drawRect(x, y, w, h, color: _color); 
  }
}
