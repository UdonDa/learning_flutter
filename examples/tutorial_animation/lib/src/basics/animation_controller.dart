import 'package:flutter/material.dart';

class AnimationControllerDemo extends StatefulWidget {
  static const String routeName = '/basics/animation_controller';

  @override
  _AnimationControllerDemoState createState() => _AnimationControllerDemoState();
}

class _AnimationControllerDemoState extends State<AnimationControllerDemo>
//  with SingleTickerProviderStateMixin {
  with TickerProviderStateMixin {

  static const Duration _duration = Duration(seconds: 1);
  AnimationController controller_1, controller_2, controller_3;

  @override
  void initState() {
    super.initState();

    controller_1 = AnimationController(vsync: this, duration: _duration)
      ..addListener(() {
        setState(() {});
      }
    );
    controller_2 = AnimationController(vsync: this, duration: _duration)
      ..addListener(() {
        setState(() {});
      }
    );
    controller_3 = AnimationController(vsync: this, duration: _duration)
      ..addListener(() {
        setState(() {});
      }
    );
  }

  @override
  void dispose() {
    controller_1.dispose();
    controller_2.dispose();
    controller_3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200),
              child: Text(
                '${controller_1.value.toStringAsFixed((2))}',
                style: Theme.of(context).textTheme.headline3,
                textScaleFactor: 1 + controller_1.value,
//                textScaleFactor: 1,
              )
            ),
            RaisedButton(
              child: Text('animate'),
              onPressed: () {
                if (controller_1.status == AnimationStatus.completed) {
                  controller_1.reverse();
                } else {
                  controller_1.forward();
                }
              },
            ),
            ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200),
                child: Text(
                  '${controller_2.value.toStringAsFixed((2))}',
                  style: Theme.of(context).textTheme.headline3,
                  textScaleFactor: 1,
                )
            ),
            RaisedButton(
              child: Text('animate'),
              onPressed: () {
                if (controller_2.status == AnimationStatus.completed) {
                  controller_2.reverse();
                } else {
                  controller_2.forward();
                }
              },
            ),
            ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 200),
                child: Text(
                  '${controller_3.value.toStringAsFixed((2))}',
                  style: Theme.of(context).textTheme.headline3,
                  textScaleFactor: 1 + controller_3.value,
                )
            ),
            RaisedButton(
              child: Text('animate'),
              onPressed: () {
                if (controller_3.status == AnimationStatus.completed) {
                  controller_3.reverse();
                } else {
                  controller_3.forward();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}




