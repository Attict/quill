# Quill

A lightweight game engine, that only uses feathers.

## Why Quill?

The idea of Quill is to give you full control over your game or application.  
Using Quill is simple, everything is a node based `Feather`, but your Feathers can
turn into a `Quill`, which contains many of the `Component` class.  Quills can be
preset to contain specific components.  You can use preset Quills, or you can 
create your own!

## Quick Start

**lib/main.dart**
```dart
import 'package:quill/quill.dart';
import 'dart:ui'

void main() async {
  /// Start the application with 60.0 frames per second
  new QuillEngine(new Application(), fps: 60.0)
    ..start();
}

class Application extends Feather {
  /// `Sprite` is a `Quill` preset
  Sprite user;
  @override
  void init() {
    /// Create a 
    user = new Sprite()..initWithColor(const Color(0xFFFF0000), 
        const Point(0.0, 0.0), const Size(100.0, 100.0));
    this.addFeather('user', user);
    super.init();
  }

  @override
  void update(Time time) {
    super.update(time);
    /// Move the user 10 pixels per second
    user.position.x += 10.0 * time.elapsedSeconds;
  }
}
```
## The Feather Loop

Each feather, and all associated components follow a main way of looping. 
Primarily through the **input, update, and render** methods.

`init`: Initializes the feather/component.

`destroy`: Disposes of the feather/component, and all internal properties.

`load`: Loads any data neccessary for the feather/component.

`unload`: Unloads any data, to make room for loading new data.

`input`: Handles input events as neccessary for the feather/component.

`update`: Updates our feather/component.

`render`: Draws our feather/component to the screen.

## Custom Components & Quills

Creating custom components & quills is simple, you just need to extend the `Quill` or 
`Component` class.  Use the *Feather Loop* above to override any methods you need, or
create your own unique methods.  Try to be consistent, and avoid using constructors, 
as there are plans to remove the use of them as soon as possible.  So, rather than 
passing parameters in the constructor, use a custom setter such as 
`setSize(double width, double height);` like the `SizeComponent`.  For Quills, using 
custom initializers works great, like the `Sprite` quill:
`initWithColor(Color color, Point position, Size size)`... then you can initialize 
each of these as components!

## Upcoming

Please note that Quill is still in it's early stages, so there are a lot of missing features.
I have finally gotten the foundation finalized, so now it's just a matter of adding each of
these features.  Here is a list of upcoming features:

* Audio
* Image Caching


## Suggestions & Feedback

I hope this library helps others build their games rapidly an easily.  Any feedback that 
could help make Quill even better, are more than welcome!  Please use github as an open
way to communicate those ideas. 

## Contributing

I hope that one day there will be a community of components and quills to help new users 
streamline their app development.

_More Coming soon..._
