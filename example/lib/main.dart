import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

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
                  const SizedBox(
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
    return const SizedBox(
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
    return SizedBox(
      width: 300,
      child: PlaceholderLines(
        count: 3,
        align: align,
      ),
    );
  }

  Widget _buildSubtitle(String title) {
    return Container(
      padding: const EdgeInsets.only(
        top: 24,
        bottom: 16,
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  _buildAnimated() {
    return const AnimatedWrapper();
  }

  _buildCardExample() {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 9,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        width: 300,
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.6),
              ),
              child: const Center(
                child: Icon(
                  Icons.photo_size_select_actual,
                  color: Colors.white,
                  size: 38,
                ),
              ),
            ),
            const Expanded(
              child: PlaceholderLines(
                count: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedWrapper extends StatefulWidget {
  const AnimatedWrapper({
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedWrapperState createState() => _AnimatedWrapperState();
}

class _AnimatedWrapperState extends State<AnimatedWrapper> {
  bool _animated = true;
  @override
  void initState() {
    super.initState();
    _changeState();
  }

  _changeState() {
    setState(() {
      _animated = !_animated;
    });
    Future.delayed(const Duration(seconds: 5)).then((_) => _changeState());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: PlaceholderLines(
        count: 3,
        animate: _animated,
        color: Colors.purple,
      ),
    );
  }
}
