part of quill;

class Label extends Quill {
  bool initialized = false;
  String get text => getComponent<TextComponent>().text;
  set text(String text) => getComponent<TextComponent>().text = text;
  Point get position => new Point(
      getComponent<PositionComponent>().x, getComponent<PositionComponent>().y);
  void initWithText(String text) {
    if (!initialized) {
      addComponent<TextComponent>(new TextComponent())..setText(text);
      initialized = true;
    }
  }

  void setPosition(double x, double y) {
    if (!hasComponent<PositionComponent>()) {
      addComponent<PositionComponent>(new PositionComponent());
    }
    getComponent<PositionComponent>().setPosition(x, y);
  }

  set textStyle(TextStyle textStyle) {
    getComponent<TextComponent>().textStyle = textStyle;
  }

  set paragraphConstraints(ParagraphConstraints paragraphConstraints) {
    getComponent<TextComponent>().paragraphConstraints = paragraphConstraints;
  }

  set paragraphStyle(ParagraphStyle paragraphStyle) {
    getComponent<TextComponent>().paragraphStyle = paragraphStyle;
  }
}
