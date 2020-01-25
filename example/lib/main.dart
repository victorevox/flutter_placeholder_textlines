import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    String title = "flutter_placeholder_textlines Demo";
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  _buildSubtitle("Centered"),
                  _buildSimpleTextPlaceholder(TextAlign.center),
                  _buildSubtitle("Left"),
                  _buildSimpleTextPlaceholder(TextAlign.left),
                  _buildSubtitle("Right"),
                  _buildSimpleTextPlaceholder(TextAlign.right),
                  _buildSubtitle("Change color/size"),
                  _buildCustomColorSizePlaceholder(),
                  _buildSubtitle("Animated"),
                  _buildAnimated(),
                  _buildSubtitle("Card Example"),
                  _buildCardExample(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

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
      // decoration: BoxDecoration(color: Colors.yellow),
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
      // decoration: BoxDecoration(color: Colors.yellow),
      width: 300,
      child: PlaceholderLines(
        count: 3,
        animate: true,
        color: Colors.purple,
        // align: align,
      ),
    );
  }

  _buildCardExample() {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 9,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        // decoration: BoxDecoration(color: Colors.yellow),
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
                // align: align,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildSimpleTextPlaceholder(TextAlign align) {
  //   return
  // }
}
