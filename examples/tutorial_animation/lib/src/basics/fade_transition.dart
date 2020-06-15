import 'package:flutter/material.dart';

class FadeTransitionDemo extends StatefulWidget {
  static const String routeName = '/basics/fade_transition';

  @override
  _FadeTransitionDemoState createState () => _FadeTransitionDemoState();
}

class _FadeTransitionDemoState extends State<FadeTransitionDemo>
  with SingleTickerProviderStateMixin {

  static const Duration _duration = Duration(milliseconds: 500);
  AnimationController _controller;
  Animation<double> _animation;
  CurvedAnimation _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _animation = Tween(begin: 1.0, end: 0.0).animate(_curve);
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FadeTransition(
              opacity: _animation,
              child: Icon(
                Icons.star,
                color: Colors.amber,
                size: 300,
              ),
            ),
            RaisedButton(
//            MaterialButton(
              child: Text('Animate'),
              onPressed: () => setState(() {
                _controller.animateTo(1.0).then<TickerFuture>(
                    (value) => _controller.animateBack(0.0)
                );}
              ),
              color: Colors.deepOrange,
            )
          ],
        ),
      ),
    );
  }
}