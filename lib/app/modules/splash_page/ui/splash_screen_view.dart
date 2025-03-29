// ignore_for_file: unused_field, constant_identifier_names

import 'package:flutter/material.dart';

import '../widget/colorized_animated_text.dart';
import '../widget/scale_animated_text.dart';
import '../widget/typer_animated_text.dart';

// ignore: must_be_immutable
class SplashScreenView extends StatefulWidget {
  SplashScreenView({
    super.key,
    final Widget? navigateRoute,
    final String? imageSrc,
    final int? duration,
    final int? imageSize,
    final TextStyle? textStyle,
    final int? speed,
    final PageRouteTransition? pageRouteTransition,
    final List<Color>? colors,
    final TextType? textType,
    final Color? backgroundColor,
    final String? text,
  }) {
    _imageSrc = imageSrc;
    _widget = navigateRoute;
    _speed = speed;
    _duration = duration;
    _pageRouteTransition = pageRouteTransition;
    _colors = colors;
    _text = text;
    _textStyle = textStyle;
    _logoSize = imageSize;
    _backgroundColor = backgroundColor;
    _textType = TextType.values.firstWhere(
      (final TextType f) => f == textType,
      orElse: () => TextType.NormalText,
    );
  }

  /// The [Widget] Name of target screen which you want to display after completion of splash screen milliseconds.
  Widget? _widget;

  ///  [String] Asset path of your logo image.
  String? _imageSrc = '';

  /// Check if network image
  bool isNetworkImage = false;

  /// defines standard behaviors when transitioning between routes (or screens)
  ///
  /// By default is  is Normal
  PageRouteTransition? _pageRouteTransition;

  ///  [String] that would be displayed on below logo.
  String? _text;

  /// Select [TextType] of your text.
  ///
  /// By default it is NormalText.
  TextType? _textType;

  /// Gives [TextStyle] to the text strings.
  TextStyle? _textStyle;

  /// The [Duration] of the delay between the apparition of each characters
  ///
  /// By default it is set to 1000 milliseconds.
  int? _duration = 1000;

  /// The [Speed] of the delay between the apparition of each characters
  ///
  /// By default it is set to 75 milliseconds.
  int? _speed = 75;

  ///  [int] Size of your image logo.
  ///
  /// By default it is set to 150.
  int? _logoSize = 150;

  ///  [Color] Background Color of your splash screen.
  /// By default it is set to white.
  Color? _backgroundColor = Colors.white;

  /// Set the colors for the gradient animation of the text.
  ///
  /// The [List] should contain at least two values of [Color] in it.
  /// By default it is set to red and black.
  List<Color>? _colors;

  final double _defaultTextFontSize = 20;

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    if (widget._duration == null) {
      widget._duration = 1000;
    } else if (widget._duration! < 500) {
      widget._duration = 1000;
    }

    if (widget._imageSrc != null && widget._imageSrc!.isNotEmpty) {
      if (widget._imageSrc!.startsWith('http://') ||
          widget._imageSrc!.startsWith('https://')) {
        widget.isNetworkImage = true;
      } else {
        widget.isNetworkImage = false;
      }
    } else {
      widget.isNetworkImage = false;
    }

    if (widget._textType == TextType.TyperAnimatedText) {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 100),
      );
      _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Curves.easeInCirc,
        ),
      );
      _animationController!.forward();
    } else {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      );
      _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Curves.easeInCirc,
        ),
      );
      _animationController!.forward();
    }

    // Future.delayed(Duration(milliseconds: widget._duration!)).then((value) {
    //   if (widget._pageRouteTransition ==
    //       PageRouteTransition.CupertinoPageRoute) {
    //     Navigator.of(context).pushReplacement(CupertinoPageRoute(
    //         builder: (BuildContext context) => widget._widget!));
    //   } else if (widget._pageRouteTransition ==
    //       PageRouteTransition.SlideTransition) {
    //     Navigator.of(context).pushReplacement(_tweenAnimationPageRoute());
    //   } else {
    //     Navigator.of(context).pushReplacement(_normalPageRoute());
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController!.reset();
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: widget._backgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffE8BDF1),
              Color(0xffB8E7F5),
              // SGColors.lightPink,
              // SGColors.blueShade1,
            ],
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FadeTransition(
          opacity: _animation!,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (widget._imageSrc != null && widget._imageSrc!.isNotEmpty)
                (widget.isNetworkImage)
                    ? Image.network(
                        widget._imageSrc!,
                        height: (widget._logoSize != null)
                            ? widget._logoSize!.toDouble()
                            : 150,
                      )
                    : Hero(
                        tag: 'SplashScreenLogo',
                        child: Image.asset(
                          widget._imageSrc!,
                          height: (widget._logoSize != null)
                              ? widget._logoSize!.toDouble()
                              : 150,
                        ),
                      )
              else
                const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
                child: getTextWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getTextWidget() {
    if (widget._text != null) {
      //print("Not Blank");
      switch (widget._textType) {
        case TextType.ColorizeAnimationText:
          return ColorizeAnimatedText(
            text: widget._text,
            speed: const Duration(milliseconds: 1000),
            textStyle: (widget._textStyle != null)
                ? widget._textStyle
                : TextStyle(fontSize: widget._defaultTextFontSize),
            colors: (widget._colors != null)
                ? widget._colors!
                : [
                    Colors.blue,
                    Colors.black,
                    Colors.blue,
                    Colors.black,
                  ],
          );
        case TextType.NormalText:
          return Text(
            widget._text!,
            style: (widget._textStyle != null)
                ? widget._textStyle
                : TextStyle(fontSize: widget._defaultTextFontSize),
          );
        case TextType.TyperAnimatedText:
          return TyperAnimatedText(
            text: widget._text,
            speed: (widget._speed == null)
                ? const Duration(milliseconds: 100)
                : Duration(milliseconds: widget._speed!),
            textStyle: (widget._textStyle != null)
                ? widget._textStyle
                : TextStyle(fontSize: widget._defaultTextFontSize),
          );
        case TextType.ScaleAnimatedText:
          return ScaleAnimatedText(
            text: widget._text,
            textStyle: (widget._textStyle != null)
                ? widget._textStyle
                : TextStyle(fontSize: widget._defaultTextFontSize),
          );
        default:
          return Text(
            widget._text!,
            style: (widget._textStyle != null)
                ? widget._textStyle
                : TextStyle(fontSize: widget._defaultTextFontSize),
          );
      }
    } else {
      //print("Blank");
      return const SizedBox(
        width: 1,
      );
    }
  }
}

enum TextType {
  ColorizeAnimationText,
  TyperAnimatedText,
  ScaleAnimatedText,
  NormalText,
}

enum PageRouteTransition {
  Normal,
  CupertinoPageRoute,
  SlideTransition,
}
