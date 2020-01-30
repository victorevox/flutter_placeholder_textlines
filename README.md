# flutter_placeholder_textlines

A simple plugin to generate placeholder lines that emulates text in a UI, useful for displaying placeholder content while loading or empty items

## Example of Usage

```dart
Widget _buildCustomColorSizePlaceholder() {
    return Container(
      width: 200,
      child: PlaceholderLines(
        count: 4,
        align: TextAlign.center,
        lineHeight: 8,
        color: Colors.blueAccent,
      ),
    );
  }

  Widget _buildSimpleTextPlaceholder(TextAlign align) {
    return Container(
      width: 300,
      child: PlaceholderLines(
        count: 3,
        align: align,
      ),
    );
  }

  Widget _buildSubtitle(String title) {
    return Container(
      padding: EdgeInsets.only(
        top: 24,
        bottom: 16,
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  _buildAnimated() {
    return Container(
      width: 300,
      child: PlaceholderLines(
        count: 3,
        animate: true,
        color: Colors.purple,
      ),
    );
  }

  _buildCardExample() {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 9,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        width: 300,
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16),
              width: 70,
              height: 70,
              decoration: BoxDecoration(color: Colors.grey.withOpacity(.6), ),
              child: Center(child: Icon(Icons.photo_size_select_actual, color: Colors.white, size: 38,),),
            ),
            Expanded(
              child: PlaceholderLines(
                count: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
  ```

  ## API Options

  ```dart
  /// Defines how many lines to build
  final int count;

  /// Defines `color` to be used as base when building each line
  final Color color;

  /// Defines `alignment` for all the lines generated
  final TextAlign align;

  /// Defines the `min` value for the `opacity` that a line could have, since color opacity it's generated randomly ,
  /// this prevents the value from going to low (making it invisible)
  /// defaults to [0.4]
  final double minOpacity;

  /// Defines the `max` value for the `opacity` that a line could have, since color opacity it's generated randomly ,
  /// defaults to [0.94]
  final double maxOpacity;

  /// Defines the `max` `width` that a line could have, since `width` it's generated randomly
  /// defaults to [.95]
  final double maxWidth;

  /// Defines the `min` `width` that a line could have, since `width` it's generated randomly
  /// defaults to [.72]
  final double minWidth;

  /// Defines the line `height`
  /// defaults to [12]
  final double lineHeight;

  /// if [true], plays a nice animation of an overlay
  final bool animate;

  /// Use a [customAnimationOverlay] to display instead of the difault one
  final Widget customAnimationOverlay;

  /// Set a custom [animationOverlayColor]
  final Color animationOverlayColor;

  /// If [true] , this will cause the lines to be rebuild with different widths (randomly generated)
  /// every time any parent widget rebuilds it's state
  /// defaults to [false]
  final bool rebuildOnStateChange;
  ```

  Also please see example at: https://github.com/victorevox/flutter_placeholder_textlines/tree/master/example


  ## Screenshots

  <img src="https://raw.githubusercontent.com/victorevox/flutter_placeholder_textlines/master/example/Screenshot_1.png" align = "left" height = "350" alt="examples">

  <img src="https://raw.githubusercontent.com/victorevox/flutter_placeholder_textlines/master/example/Screenshot_1.png" align = "left" height = "350" alt="examples 2">

  <img src="https://raw.githubusercontent.com/victorevox/flutter_placeholder_textlines/master/example/example.gif" height = "350" alt="examples gif">


  ## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.