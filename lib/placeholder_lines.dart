import 'dart:math';

import 'package:flutter/widgets.dart';

class PlaceholderLines extends StatefulWidget {
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
  final Widget? customAnimationOverlay;

  /// Set a custom [animationOverlayColor]
  final Color? animationOverlayColor;

  /// If [true] , this will cause the lines to be rebuild with different widths (randomly generated)
  /// every time any parent widget rebuilds it's state
  /// defaults to [false]
  final bool rebuildOnStateChange;

  const PlaceholderLines({
    Key? key,
    required this.count,
    this.align = TextAlign.left,
    this.color = const Color(0xFFDEDEDE),
    this.minOpacity = 0.4,
    this.maxOpacity = 0.94,
    this.maxWidth = .95,
    this.minWidth = .72,
    this.lineHeight = 12,
    this.animate = false,
    this.customAnimationOverlay,
    this.animationOverlayColor,
    this.rebuildOnStateChange = false,
  })  : assert(count is int),
        assert(minOpacity <= 1 && maxOpacity <= 1),
        assert(minWidth <= 1 && maxWidth <= 1),
        assert(minOpacity is double),
        assert(maxOpacity is double),
        assert(minOpacity <= maxOpacity),
        super(key: key);

  @override
  _PlaceholderLinesState createState() => _PlaceholderLinesState();
}

class _PlaceholderLinesState extends State<PlaceholderLines>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<RelativeRect>? _animation;
  late Map<int, double> _seeds;

  double get _randomSeed => Random().nextDouble();

  @override
  void didUpdateWidget(PlaceholderLines oldWidget) {
    if (oldWidget.animate != widget.animate) {
      if (widget.animate) {
        // _setupAnimation();
        _animationController.forward();
      } else {
        // if(_animationController != null) {
        //   _animationController.dispose();
        //   _animationController = null;
        // }
        _animationController.stop();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _seeds = List.filled(widget.count, 0).asMap().map((index, _) {
      return MapEntry(index, _randomSeed);
    });

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance!.addPostFrameCallback(_setupAnimation);
    // if(widget.animate) {
    // }
    super.initState();
  }

  void _setupAnimation([Duration? _]) {
    if(!mounted) return;
    
    final RenderBox? renderO = context.findRenderObject() as RenderBox;

    if (renderO == null) {
      throw Exception(
          "RenderBox not found -- could not calculate BoxConstraints for "
          "placeholder_lines");
    }

    final BoxConstraints constraints = renderO.constraints;
    final double maxWidth = _getMaxConstrainedWidth(constraints);
    final CurvedAnimation curvedAnimation = CurvedAnimation(
      curve: Curves.easeIn,
      reverseCurve: Curves.easeInOut,
      parent: _animationController,
    );
    _animation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, 0, maxWidth, 0),
      end: RelativeRect.fromLTRB(maxWidth, 0, -maxWidth, 0),
    ).animate(curvedAnimation)
      ..addStatusListener(
        (status) {
          if (!widget.animate) return;
          if (status == AnimationStatus.completed) {
            _animationController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _animationController.forward();
          }
        },
      );
    setState(() {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    CrossAxisAlignment _alignment = this.widget.align == TextAlign.left
        ? CrossAxisAlignment.start
        : this.widget.align == TextAlign.right
            ? CrossAxisAlignment.end
            : this.widget.align == TextAlign.center
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.baseline;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: _alignment,
            children: _buildLines(constraints),
          ),
        );
      },
    );
  }

  List<Widget> _buildLines(BoxConstraints constraints) {
    List<Widget> list = [];
    for (var i = 0; i < widget.count; i++) {
      double _random = widget.rebuildOnStateChange ? _randomSeed : _seeds[i]!;
      double _opacity = (widget.maxOpacity -
              ((widget.maxOpacity - widget.minOpacity) * _random))
          .abs();
      // double realMaxWidth = constraints.maxWidth;
      double constrainedMaxWidth = _getMaxConstrainedWidth(constraints);
      double constrainedMinWidth = _getMinConstrainedWidth(constraints);
      double _width = (constrainedMaxWidth -
              ((constrainedMaxWidth - constrainedMinWidth) * _random))
          .abs();
      final Widget staticWidget = Container(
        height: widget.lineHeight,
        width: _width,
        decoration: BoxDecoration(
          color: widget.color.withOpacity(_opacity),
        ),
      );
      list.add(
        AnimatedSwitcher(duration: Duration(milliseconds: 400),child: _animation != null && widget.animate == true
            ? AnimatedBuilder(
                animation: _animation!,
                child: staticWidget,
                builder: (context, child) {
                  return Container(
                    // decoration: BoxDecoration(color: Colors.purple),
                    child: ClipRect(
                      child: Stack(
                        clipBehavior: Clip.antiAlias,
                        children: <Widget>[
                          if (child != null) child,
                          Transform.translate(
                            offset: Offset(_animation!.value.left, 0),
                            child: widget.customAnimationOverlay ??
                                Container(
                                  height: widget.lineHeight,
                                  width: _width / 3,
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        blurRadius: 18,
                                        color: widget.animationOverlayColor ??
                                            Color(0xFFFFFFFF),
                                        offset: Offset(4, 3)),
                                    BoxShadow(
                                        blurRadius: 28,
                                        color: widget.animationOverlayColor ??
                                            Color(0xFFFFFFFF),
                                        offset: Offset(1, 3)),
                                  ]),
                                ),
                          )
                        ],
                      ),
                    ),
                  );
                },)
            : staticWidget,),
      );
      if (i < widget.count - 1) {
        list.add(SizedBox(
          height: widget.lineHeight,
        ));
      }
    }
    return list;
  }

  double _getMaxConstrainedWidth(BoxConstraints constraints) {
    double realMaxWidth = constraints.maxWidth;
    return realMaxWidth * widget.maxWidth;
  }

  double _getMinConstrainedWidth(BoxConstraints constraints) {
    double realMaxWidth = constraints.maxWidth;
    return realMaxWidth * widget.minWidth;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}