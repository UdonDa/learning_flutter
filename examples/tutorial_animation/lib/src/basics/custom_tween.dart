import 'package:flutter/material.dart';

class TypewriterTween extends Tween<String> {
  TypewriterTween({String begin = '', String end})
    : super(begin: begin, end: end);

  @override
  String lerp(double t) {
    var cutoff = (end.length * t).round();
    return end.substring(0, cutoff);
  }
}

class CustomTweenDemo extends StatefulWidget {
  static const String routeName = '/basics/custom_tweens';

  @override
  _CustomTweenDemoState createState() => _CustomTweenDemoState();
}

class _CustomTweenDemoState extends State<CustomTweenDemo>
  with SingleTickerProviderStateMixin {

  static const Duration _duration = Duration(seconds: 3);
  static const String message = loremIpsum;
  AnimationController controller;
  Animation<String> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: _duration);
    animation = TypewriterTween(end: message).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            child: Text(
              controller.status == AnimationStatus.completed
                  ? 'Delete Essay'
                  : 'Write Essey',
            ),
            textColor: Colors.white,
            onPressed: () {
              if (controller.status == AnimationStatus.completed) {
                controller.reverse().whenComplete(() => setState(() {}));
              } else {
                controller.forward().whenComplete(() => setState(() {}));
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Text(
                    '${animation.value}',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'SpecialElite'
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}

const String loremIpsum = 'Tenpura udon';