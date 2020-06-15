import 'package:flutter/material.dart';

class AnimatedBuilderDemo extends StatefulWidget {
  static const String routeName = '/basics/animated_builder';

  @override
  _AnimatedBuilderDemoState createState() => _AnimatedBuilderDemoState();
}

class _AnimatedBuilderDemoState extends State<AnimatedBuilderDemo>
  with SingleTickerProviderStateMixin {

  static const Color beginColor = Colors.deepPurple;
  static const Color endColor = Colors.deepOrange;
  Duration duration = Duration(milliseconds: 800);
  AnimationController controller;
  Animation<Color> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: duration);
    animation = ColorTween(begin: beginColor, end: endColor).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return MaterialButton(
              color: animation.value,
              child: child,
              onPressed: () {
                if (controller.status == AnimationStatus.completed) {
                  controller.reverse();
                } else {
                  controller.forward();
                }
              },
            );
          },
          child: Text(
            'Change color',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}