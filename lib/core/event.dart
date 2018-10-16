part of quill;

class Event {
  static const int tap = 1;
  static const int touchdown = 11;
  static const int touchup = 12;

  final Point _position;
  Point get position => _position;

  final int _type;
  int get type => _type;

  Event(this._type, this._position);

  bool get isTouchdown => _type == touchdown;
  bool get isTouchup => _type == touchup;

  @override
  String toString() {
    return '';
  }
}
