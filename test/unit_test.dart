import 'package:test/test.dart';
import 'package:quill/quill.dart';

void main() {
  testSprite();
  testLabel();
  testCollision();
}

void testSprite() {
  Sprite sprite = new Sprite()
    ..setPosition(10.0, 10.0)
    ..setSize(100.0, 100.0);

  test("test sprite", () {
    expect(sprite.position.x, 10.0);
    expect(sprite.position.y, 10.0);
    expect(sprite.size.width, 100.0);
    expect(sprite.size.height, 100.0);
    expect(sprite.position.offset.x, 50.0);
    expect(sprite.position.offset.y, 50.0);
    expect(sprite.position.drawAt.x, -40.0);
    expect(sprite.position.drawAt.y, -40.0);
  });
}

void testLabel() {
  Label label = new Label()
    ..initWithText('hello')
    ..setPosition(30.0, 30.0);

  test("test label", () {
    expect(label.text, 'hello');
    expect(label.position.x, 30.0);
    expect(label.position.y, 30.0);
  });
}

void testCollision() {
  Sprite quillA = new Sprite()
    ..setPosition(25.0, 25.0)
    ..setSize(100.0, 100.0);
  CollisionComponent collider = 
    quillA.addComponent<CollisionComponent>(new CollisionComponent());
  Sprite quillB = new Sprite()
    ..setPosition(35.0, 35.0)
    ..setSize(100.0, 100.0);

  test('test collision', () {
    expect(collider.isColliding(quillB), true);
  });

}