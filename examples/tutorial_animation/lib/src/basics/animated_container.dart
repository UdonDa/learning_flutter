import 'dart:math';
import 'package:flutter/material.dart';


double generateBourderRadius() => Random().nextDouble() * 64;
double generateMargin() => Random().nextDouble() * 64;
Color generateColor() => Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));

class AnimatedContainerDemo extends StatefulWidget {
  static String routeName = '/basics/animated_container';

  @override
  _AnimatedContainerDemoState createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  Color color;
  double borderRadius;
  double margin;

  @override
  void initState() {
    super.initState();
    color = Colors.deepOrange;
    borderRadius = generateBourderRadius();
    margin = generateMargin();
  }

  void change() {
    setState(() {
      color = generateColor();
      borderRadius = generateBourderRadius();
      margin = generateMargin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: 128,
                height: 128,
                child: AnimatedContainer(
                  margin: EdgeInsets.all(margin),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  duration: const Duration(milliseconds: 200),
                )
              ),
            ),
            RaisedButton(
              child: Text(
                'change'
              ),
              color: Colors.red[100],
              onPressed: () => change(),
            )
          ],
        )
      ),
    );
  }
}