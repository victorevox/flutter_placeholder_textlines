# flutter_placeholder_textlines

A simple plugin to generate placeholder lines that emulates text in a UI, useful for displaying placeholder content while loading or empty items

## Example of Usage

```
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