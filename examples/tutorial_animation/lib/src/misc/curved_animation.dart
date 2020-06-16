import 'dart:math' as math;
import 'package:flutter/material.dart';

class CurvedAnimationDemo extends StatefulWidget {
  static const String routeName = '/misc/curved_animation';

  @override
  _CurvedAnimationDemoState createState() => _CurvedAnimationDemoState();
}

class CurveChoice {
  final Curve curve;
  final String name;
  const CurveChoice({this.curve, this.name});
}

class _CurvedAnimationDemoState extends State<CurvedAnimationDemo> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animationRotation;
  Animation<Offset> _animationTranslation;
  static const Duration _duration = Duration(seconds: 4);

  List<CurveChoice> _curves = [
    CurveChoice(curve: Curves.bounceIn, name: 'Bounce In'),
    CurveChoice(curve: Curves.bounceOut, name: 'Bounce Out'),
    CurveChoice(curve: Curves.easeInCubic, name: 'Ease In Cubic'),
    CurveChoice(curve: Curves.easeOutCubic, name: 'Ease Out Cubic'),
    CurveChoice(curve: Curves.easeInExpo, name: 'Ease In Expo'),
    CurveChoice(curve: Curves.easeOutExpo, name: 'Ease Out Expo'),
    CurveChoice(curve: Curves.elasticIn, name: 'Elastic In'),
    CurveChoice(curve: Curves.elasticOut, name: 'Elastic Out'),
    CurveChoice(curve: Curves.easeInQuart, name: 'Ease In Quart'),
    CurveChoice(curve: Curves.easeOutQuart, name: 'Ease Out Quart'),
    CurveChoice(curve: Curves.easeInCirc, name: 'Ease In Circle'),
    CurveChoice(curve: Curves.easeOutCirc, name: 'Ease Out Circle'),
  ];

  CurveChoice _selectedForwardCurve, _selectedReverseCurve;
  CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _selectedForwardCurve = _curves[0];
    _selectedReverseCurve = _curves[0];
    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: _selectedForwardCurve.curve,
      reverseCurve: _selectedReverseCurve.curve
    );
    _animationRotation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
    _animationTranslation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(1, 0),
    ).animate(_curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Curved Animation'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.0,),
          Text(
            'Select Curve for forward animation',
            style: Theme.of(context).textTheme.headline6,
          ),
          DropdownButton<CurveChoice>(
            items: _curves.map((curve) {
              return DropdownMenuItem<CurveChoice>(
                value: curve, child: Text(curve.name),
              );
            }).toList(),
            onChanged: (newCurve) {
              setState(() {
                _selectedForwardCurve = newCurve;
                _curvedAnimation.curve = _selectedForwardCurve.curve;
              });
            },
            value: _selectedForwardCurve,
          ),
          SizedBox(height: 15.0),
          Text(
            'Select Curve for reverse animation',
            style: Theme.of(context).textTheme.headline6,
          ),
          DropdownButton<CurveChoice>(
            items: _curves.map((curve) {
              return DropdownMenuItem<CurveChoice>(
                value: curve, child: Text(curve.name),
              );
            }).toList(),
            onChanged: (newCurve) {
              setState(() {
                _selectedReverseCurve = newCurve;
                _curvedAnimation.reverseCurve = _selectedReverseCurve.curve;
              });
            },
            value: _selectedReverseCurve,
          ),
          SizedBox(height: 35.0,),
          Transform.rotate(
            angle: _animationRotation.value,
            child: Center(
              child: Container(
                child: FlutterLogo(
                  size: 100,
                ),
              ),
            ),
          ),
          SizedBox(height: 35.0,),
          FractionalTranslation(
            translation: _animationTranslation.value,
            child: Container(
              child: FlutterLogo(
                size: 100,
              ),
            ),
          ),
          SizedBox(height: 25.0,),
          RaisedButton(
            onPressed: () => _controller.forward(),
            child: Text('Animate'),
          )
        ],
      ),
    );
  }


}