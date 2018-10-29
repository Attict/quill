part of quill;

enum TextOptions {
  direction_ltr,
  direction_rtl,
  align_left,
  align_center,
  align_right,
  align_justify,
  style_italic,
  style_bold,
  style_underline
}

class TextComponent extends Component {
  Paragraph paragraph;
  String _text;
  String get text => _text;
  set text(String text) {
    _text = text;
    format();
  }

  void setText(String text) {
    _text = text;
  }

  @override
  void init() {
    super.init();
    if (paragraph == null) {
      format();
    }
  }

  @override
  void render(Context context) {
    super.render(context);
    PositionComponent position = quill.getComponent<PositionComponent>();

    context.canvas
      ..drawParagraph(this.paragraph, new Offset(position.x, position.y));
  }

  TextStyle _textStyle;
  TextStyle get textStyle => _textStyle;
  set textStyle(TextStyle textStyle) {
    _textStyle = textStyle;
    format();
  }

  ParagraphStyle _paragraphStyle;
  ParagraphStyle get paragraphStyle => _paragraphStyle;
  set paragraphStyle(ParagraphStyle paragraphStyle) {
    _paragraphStyle = paragraphStyle;
    format();
  }

  ParagraphConstraints _paragraphConstraints;
  ParagraphConstraints get paragraphConstraints => _paragraphConstraints;
  set paragraphConstraints(ParagraphConstraints paragraphConstraints) {
    _paragraphConstraints = paragraphConstraints;
    format();
  }

  void format() {
    //final ParagraphBuilder builder = new ParagraphBuilder(new ParagraphStyle(textDirection: TextDirection.ltr))
    //    ..pushStyle(new TextStyle(color: const Color(0xFF0000FF)))
    //    ..addText('Hello, ')
    //    ..pushStyle(new TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold))
    //    ..addText('world. ')
    //    ..pop()
    //    ..addText('Standard style.');

    //paragraph = builder.build()
    //    ..layout(new ParagraphConstraints(width: 200.0));

    if (textStyle == null) {
      _textStyle =
          new TextStyle(color: const Color(0xFFF00000), fontSize: 16.0);
    }
    if (paragraphConstraints == null) {
      _paragraphConstraints = new ParagraphConstraints(width: 250.0);
    }
    if (paragraphStyle == null) {
      _paragraphStyle = new ParagraphStyle(textDirection: TextDirection.ltr);
    }
    final ParagraphBuilder builder = new ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(_text);

    paragraph = builder.build()..layout(paragraphConstraints);
  }
}
