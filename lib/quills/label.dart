part of quill;

class Label extends Quill {
  bool initialized = false;
  set text(String text) => getComponent<TextComponent>().text = text;
  void initWithText(String text, Point position) {
    if (!initialized) {
      addComponent<TextComponent>(new TextComponent())
        ..setText(text);
      addComponent<PositionComponent>(new PositionComponent())
        ..setPosition(position.x, position.y);
      initialized = true;
    }
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
